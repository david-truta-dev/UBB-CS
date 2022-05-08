package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.Expressions.ValueExp;
import Model.PrgState;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.Value;

public class WaitStmt implements IStmt{
    private final Exp e;

    public WaitStmt(Exp exp){
        e = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        Value eval = e.eval(state.getSymTable(), state.getHeap());
        if(eval.getType() instanceof IntType){
            IntValue iv = (IntValue) eval;
            if(iv.getValue() > 0)
                state.getStk().push(new CompStmt(new PrintStmt(new ValueExp(iv)),
                        new WaitStmt(new ValueExp(new IntValue(iv.getValue()-1)))));
            return null;
        }else throw new MyException("The expression should evaluate to an Int");
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        return typeEnv;
    }

    @Override
    public IStmt deepCopy() {
        return new WaitStmt(e.deepCopy());
    }

    @Override
    public String toString() {
        return "Wait(" + e + ')';
    }
}
