package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.Expressions.RelExp;
import Model.PrgState;
import Model.Types.Type;

public class SwitchStmt implements IStmt{
    private final Exp exp;
    private final Exp exp1;
    private final Exp exp2;
    private final IStmt stmt1;
    private final IStmt stmt2;
    private final IStmt stmt3;

    public SwitchStmt(Exp e, Exp e1, Exp e2, IStmt st1, IStmt st2, IStmt st3){
        exp = e;
        exp1 = e1;
        exp2 = e2;
        stmt1 = st1;
        stmt2 = st2;
        stmt3 = st3;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        state.getStk().push(new IfStmt(new RelExp(exp, exp1, "=="),stmt1,new IfStmt(new RelExp(exp,exp2,"=="),stmt2,stmt3)));
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typExp1=exp.typeCheck(typeEnv);
        Type typExp2=exp1.typeCheck(typeEnv);
        Type typExp3=exp2.typeCheck(typeEnv);
        if(typExp1.equals(typExp2) && typExp2.equals(typExp3)){
            stmt1.typeCheck(typeEnv.deepCopy());
            stmt2.typeCheck(typeEnv.deepCopy());
            stmt3.typeCheck(typeEnv.deepCopy());
            return typeEnv;
        }else throw new MyException("Expressions must have the same type!");
    }

    @Override
    public IStmt deepCopy() {
        return new SwitchStmt(exp.deepCopy(), exp1.deepCopy(), exp2.deepCopy(), stmt1.deepCopy(), stmt2.deepCopy(), stmt3.deepCopy());
    }

    @Override
    public String toString() {
        return "Switch(" + exp + ") { case(" + exp1 + ") : { " + stmt1 +
                " } case(" + exp2 + ") : { " + stmt2 + " } default : { " + stmt3 + " } } ";
    }

}
