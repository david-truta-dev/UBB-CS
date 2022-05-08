package Model.Statements;

import Exceptions.IfStmtException;
import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.Value;


public class IfStmt implements IStmt{
    private final Exp exp;
    private final IStmt thenS;
    private final IStmt elseS;

    public IfStmt(Exp e, IStmt t, IStmt el) {
        exp=e; thenS=t;elseS=el;
    }

    @Override
    public String toString(){
        if (this.elseS instanceof NopStmt)
            return " if ("+ exp.toString()+"): " +thenS.toString();
        return " if ("+ exp.toString()+"): " +thenS.toString()  +"; else: "+elseS.toString();
    }

    public PrgState execute(PrgState state) throws MyException {
        Value v = exp.eval(state.getSymTable(), state.getHeap());
        if(v.getType() instanceof BoolType){
            BoolValue bv = (BoolValue) exp.eval(state.getSymTable(), state.getHeap());
            if(bv.getValue())
                thenS.execute(state);
            else
                elseS.execute(state);
        } else throw new IfStmtException("Condition must evaluate to type BoolValue");
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typExp=exp.typeCheck(typeEnv);
        if (typExp.equals(new BoolType())) {
            thenS.typeCheck(typeEnv.deepCopy());
            elseS.typeCheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else throw new IfStmtException("The condition of IF must be of type bool!");
    }

    @Override
    public IStmt deepCopy() {
        return new IfStmt(this.exp, this.thenS, this.elseS);
    }
}
