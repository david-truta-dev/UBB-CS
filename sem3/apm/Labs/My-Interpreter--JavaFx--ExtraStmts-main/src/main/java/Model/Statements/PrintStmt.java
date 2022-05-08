package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.Type;

public class PrintStmt implements IStmt{
    private final Exp exp;

    public PrintStmt(Exp e) {
        this.exp = e;
    }

    public PrgState execute(PrgState state) throws MyException {
        state.getOut().insert(exp.eval(state.getSymTable(), state.getHeap()),state.getOut().size());
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        exp.typeCheck(typeEnv);
        return typeEnv;
    }

    @Override
    public String toString(){
        return "print("+exp.toString()+")";
    }

    @Override
    public IStmt deepCopy() {
        return new PrintStmt(exp);
    }
}
