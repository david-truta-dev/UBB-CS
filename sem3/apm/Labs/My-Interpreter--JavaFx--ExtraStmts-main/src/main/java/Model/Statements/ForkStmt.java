package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyDictionary;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyStack;
import Model.PrgState;
import Model.Types.Type;
import Model.Values.Value;

public class ForkStmt implements IStmt{
    IStmt stmt;

    public ForkStmt(IStmt s){
        stmt = s;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        MyStack<IStmt> nStk = new MyStack<>();
        return new PrgState(nStk, ((MyDictionary<String, Value>)state.getSymTable()).deepCopy(),
                state.getFileTable(),state.getHeap(), state.getOut(), stmt);
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        stmt.typeCheck(typeEnv.deepCopy());
        return typeEnv;
    }

    @Override
    public IStmt deepCopy() {
        return new ForkStmt(stmt.deepCopy());
    }

    @Override
    public String toString(){
        return "fork(" + stmt.toString() + ")";
    }

}
