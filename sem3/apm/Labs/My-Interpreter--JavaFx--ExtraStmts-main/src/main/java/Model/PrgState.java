package Model;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIList;
import Model.ADTs.MyIStack;
import Model.Statements.IStmt;
import Model.Values.StringValue;
import Model.Values.Value;

import java.io.BufferedReader;

public class PrgState {
    private static int nextId=1;
    private final int id;
    private final MyIStack<IStmt> exeStack;
    private final MyIDictionary<String, Value> symTable;
    private final MyIDictionary<StringValue, BufferedReader> fileTable;
    private final MyIDictionary<Integer, Value> Heap;
    private final MyIList<Value> out;
    private final IStmt originalProgram;

    public synchronized static int getNextId(){
        return nextId++;
    }

    public PrgState(MyIStack<IStmt> stk, MyIDictionary<String, Value> symtbl,
                    MyIDictionary<StringValue, BufferedReader> filetbl, MyIDictionary<Integer, Value> heap, MyIList<Value> ot, IStmt prg){
        id = getNextId();
        exeStack = stk;
        symTable = symtbl;
        fileTable = filetbl;
        Heap = heap;
        out = ot;
        originalProgram = prg.deepCopy();
        stk.push(prg);
    }

    public PrgState oneStep() throws MyException{
        if(exeStack.isEmpty()) throw new MyException("PrgState stack is empty !");
        IStmt  crtStmt = exeStack.pop();
        return crtStmt.execute(this);
    }

    public int getId() {
        return id;
    }

    public boolean isNotCompleted(){
        return !exeStack.isEmpty();
    }

    public MyIStack<IStmt> getStk(){
        return this.exeStack;
    }

    public MyIDictionary<String, Value> getSymTable(){
        return this.symTable;
    }

    public MyIDictionary<StringValue, BufferedReader> getFileTable(){
        return this.fileTable;
    }

    public MyIDictionary<Integer, Value> getHeap(){
        return this.Heap;
    }

    public MyIList<Value> getOut(){
        return this.out;
    }

    public IStmt getOriginalProgram(){ return this.originalProgram; }

    public String toString(){
        try{
            return   "PrgStateId:" + id +
                    "\nStack: " + exeStack.top().toString() + "\nSymTable: "+ symTable.toString() + "\nOut: "+
                    out.toString() + "\nFileTable" + fileTable.toString()+ "\nHeap:" + Heap.toString() + "\n";
        }catch (MyException e){
            return "PrgStateId:" + id +
                    "\nStack:" + "\nSymTable: "+ symTable.toString() + "\nOut: "+
                    out.toString() + "\nFileTable" + fileTable.toString()+ "\nHeap:" + Heap.toString() + "\n";
        }
    }

}
