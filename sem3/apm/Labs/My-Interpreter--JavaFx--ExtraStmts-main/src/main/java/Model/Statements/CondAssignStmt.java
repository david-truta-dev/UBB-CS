package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.Expressions.RelExp;
import Model.PrgState;
import Model.Types.BoolType;
import Model.Types.Type;

public class CondAssignStmt implements IStmt{
    private final String var;
    private final Exp exp1;
    private final Exp exp2;
    private final Exp exp3;

    public CondAssignStmt(String v, Exp exp1, Exp exp2, Exp exp3){
        var = v;
        this.exp1 = exp1;
        this.exp2 = exp2;
        this.exp3 = exp3;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        state.getStk().push(new IfStmt(exp1,new AssignStmt(var, exp2),
                new AssignStmt(var, exp3)));
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typExp1=exp1.typeCheck(typeEnv);
        Type typExp2=exp2.typeCheck(typeEnv);
        Type typExp3=exp3.typeCheck(typeEnv);
        Type typV=typeEnv.lookup(var).defaultValue().getType();
        if(typExp1 instanceof BoolType){
            if(typExp2.equals(typExp3) && typExp3.equals(typV))
                return typeEnv;
            else throw new MyException("v, exp2, exp3 should have the same type!");
        }
        else throw new MyException("exp1 should evaluate to a BoolValue");
    }

    @Override
    public IStmt deepCopy() {
        return new CondAssignStmt(var, exp1.deepCopy(), exp2.deepCopy(), exp3.deepCopy());
    }

    @Override
    public String toString() {
        return var + "=" + exp1 + " ? " + exp2 + " : " + exp3;
    }

}
