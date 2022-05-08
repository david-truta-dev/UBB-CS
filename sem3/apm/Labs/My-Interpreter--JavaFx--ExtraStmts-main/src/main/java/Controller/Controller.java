package Controller;


import Model.PrgState;
import Model.Statements.IStmt;
import Model.Values.RefValue;
import Model.Values.StringValue;
import Model.Values.Value;
import Repository.IRepository;
import java.io.BufferedReader;
import java.util.*;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.stream.Collectors;

public class Controller {
    private ExecutorService executor;
    private final IRepository repo;

    public Controller(IRepository r) {
        this.repo = r;
    }

    Map<Integer,Value> unsafeGarbageCollector(List<Integer> symTableAddr, Map<Integer,Value> heap){
        return heap.entrySet().stream().filter(e-> symTableAddr.contains(e.getKey())).
                collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    Map<Integer,Value> safeGarbageCollector(List<Integer> symTableAddr, Map<Integer,Value> heap){
        List<Integer>heapAddr = heap.values().stream().filter(value -> value instanceof RefValue).map(value -> {
            RefValue v1 = (RefValue) value;
            return v1.getAddress();
        }).collect(Collectors.toList());

        //Put all from heapAddr in SymTableAddr:
        heapAddr.forEach(v -> {if(!symTableAddr.contains(v)) symTableAddr.add(v);});

        return heap.entrySet().stream().filter(e-> symTableAddr.contains(e.getKey())).
                collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    List<Integer> getAddrFromSymTable(Collection<Value> symTableValues){
        return symTableValues.stream().filter(v-> v instanceof RefValue).map(v-> {RefValue v1 = (RefValue)v;
            return v1.getAddress();}).collect(Collectors.toList());
    }

    List<PrgState> removeCompletedPrg(List<PrgState> inPrgList){
        return inPrgList.stream().filter(p -> p.isNotCompleted()).collect(Collectors.toList());
    }

    void oneStepForAllPrg(List<PrgState> prgList) throws InterruptedException {
        //get callables
        List<Callable<PrgState>> callList =
                prgList.stream().map((PrgState p)->(Callable<PrgState>)(() -> {return p.oneStep();}))
                        .collect(Collectors.toList());
        //start the execution of the callables
        // it returns the list of new created PrgStates (namely threads)
        List<PrgState> newPrgList = executor.invokeAll(callList).stream().map(future -> {
            try {
                return future.get();
            } catch (InterruptedException | ExecutionException e) {
                //here you can treat the possible
                // exceptions thrown by statements'
                // execution, namely the green part
                // from previous allStep method
                System.out.println(e.getMessage());
                return null;
            }}).filter(p -> p!= null).collect(Collectors.toList());

        //add the new created threads to the list of existing threads
        prgList.addAll(newPrgList);

        //after the execution, print the PrgState List into the log file
        prgList.forEach(prg ->repo.logPrgStateExec(prg));
        //System.out.println(prgList + "\n");
        //Save the current programs in the repository
        repo.setPrgList(prgList);
    }

    public void oneStep(){
        executor = Executors.newFixedThreadPool(2);
        List<PrgState>prgList = removeCompletedPrg(repo.getPrgList());
        //print prg state in logfile:
        if(prgList.size() > 0){
            prgList.forEach(prg -> prg.getHeap().
                    setContent(safeGarbageCollector(getAddrFromSymTable(prg.getSymTable().getContent().values()),
                            prg.getHeap().getContent())));
            try {
                oneStepForAllPrg(prgList);
            } catch (InterruptedException e) {
                System.out.println(e.getMessage());
            }
        }
        repo.setPrgList(prgList);
        executor.shutdownNow();
    }

    public int getNrOfPrgStates(){
        return repo.getPrgList().size();
    }

    public List<Map.Entry<Integer, String>> getHeapTable(){
        ArrayList<Map.Entry<Integer, String>> a = new ArrayList<>();
        for(Map.Entry<Integer, Value> e : new ArrayList<>(repo.getPrgList().get(0).getHeap().getContent().entrySet()) ){
            a.add(Map.entry(e.getKey(), e.getValue().toString()));
        }
        return a;
    }

    public List<Value> getOut() {
        return new ArrayList<>(repo.getPrgList().get(0).getOut().values());
    }

    public ArrayList<IStmt> getExeStack(int prgId) {
        PrgState pg = null;
        for( PrgState prgState : new ArrayList<>(repo.getPrgList())){
            if(prgState.getId() == prgId){
                pg = prgState;break;
            }
        }
        return new ArrayList<>(pg.getStk().values());
    }

    public ArrayList<Map.Entry<String, String>> getSymTable(int prgId) {
        ArrayList<Map.Entry<String, String>> res = new ArrayList<>();
        PrgState pg = null;
        for( PrgState prgState : new ArrayList<>(repo.getPrgList())){
            if(prgState.getId() == prgId){
                pg = prgState;break;
            }
        }
        for(Map.Entry<String, Value> e : pg.getSymTable().getContent().entrySet()){
            res.add(Map.entry(e.getKey(), e.getValue().toString()));
        }
        return res;
    }

    public ArrayList<Map.Entry<String, String>> getFileTable() {
        ArrayList<Map.Entry<String, String>> a = new ArrayList<>();
        for(Map.Entry<StringValue, BufferedReader> e : new ArrayList<>(repo.getPrgList().get(0).getFileTable().getContent().entrySet()) ){
            a.add(Map.entry(e.getKey().toString(), e.getValue().toString()));
        }
        return a;
    }

    public ArrayList<Integer> getPrgStateIds() {
        ArrayList<Integer> ids = new ArrayList<>();
        for (PrgState pg : this.repo.getPrgList()){
            ids.add(pg.getId());
        }
        return ids;
    }
}
