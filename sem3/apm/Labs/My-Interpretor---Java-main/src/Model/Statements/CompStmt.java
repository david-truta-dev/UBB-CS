package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.PrgState;
import Model.Types.Type;

public class CompStmt implements IStmt {
    private final IStmt first;
    private final IStmt second;

    public CompStmt(IStmt i1, IStmt i2) {
        this.first = i1;
        this.second = i2;
    }

    @Override
    public String toString(){
        return first.toString()+"; "+second.toString();
    }

    public PrgState execute(PrgState state)  throws MyException {
        state.getStk().push(second);
        state.getStk().push(first);
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        return second.typeCheck(first.typeCheck(typeEnv));
    }

    @Override
    public IStmt deepCopy() {
        return new CompStmt(this.first.deepCopy(), this.second.deepCopy());
    }
}
