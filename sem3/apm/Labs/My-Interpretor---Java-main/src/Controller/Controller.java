package Controller;


import Exceptions.MyException;
import Model.PrgState;
import Model.Values.RefValue;
import Model.Values.Value;
import Repository.IRepository;
import java.util.Collection;
import java.util.List;
import java.util.Map;
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

    public void allSteps(){
        executor = Executors.newFixedThreadPool(2);
        //remove the completed programs
        List<PrgState>prgList = removeCompletedPrg(repo.getPrgList());
        //print prg state in logfile:
        prgList.forEach(prg ->repo.logPrgStateExec(prg));
        //System.out.println(prgList + "\n");
        while(prgList.size() > 0){
            //Calling the safe garbage collector:
            prgList.forEach(prg -> prg.getHeap().
                    setContent(safeGarbageCollector(getAddrFromSymTable(prg.getSymTable().getContent().values()),
                    prg.getHeap().getContent())));
            try {
                oneStepForAllPrg(prgList);
            } catch (InterruptedException e) {
                System.out.println(e.getMessage());
                prgList = removeCompletedPrg(repo.getPrgList());
                break;
            }
            //remove the completed programs
            prgList = removeCompletedPrg(repo.getPrgList());
        }
        executor.shutdownNow();
        // HERE the repository still contains at least one Completed Prg
        // and its List<PrgState> is not empty. Note that oneStepForAllPrg calls the method
        // setPrgList of repository in order to change the repository
        // update the repository state
        repo.setPrgList(prgList);
    }

}
