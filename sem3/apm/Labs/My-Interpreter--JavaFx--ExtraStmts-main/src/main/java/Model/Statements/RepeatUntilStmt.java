package Model.Statements;

import Exceptions.MyException;
import Exceptions.WhileStmtException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.Expressions.NotExp;
import Model.PrgState;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;

public class RepeatUntilStmt implements  IStmt{
    private final Exp cond;
    private final IStmt exe;

    public RepeatUntilStmt(IStmt e, Exp c){
        this.cond = c;
        this.exe = e;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        if(this.cond.eval(state.getSymTable(), state.getHeap()) instanceof BoolValue c){
            state.getStk().push(new CompStmt(exe, new WhileStmt(new NotExp(cond), exe)));
            return null;
        }
        else throw new WhileStmtException("The condition in Repeat Until stmt should be a BoolType!");
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typExp=cond.typeCheck(typeEnv);
        if (typExp.equals(new BoolType())) {
            exe.typeCheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else throw new MyException("The condition of RepUntil doesn't have the type bool!");
    }

    @Override
    public IStmt deepCopy() {
        return new RepeatUntilStmt(this.exe.deepCopy(), this.cond.deepCopy());
    }

    @Override
    public String toString(){
        return "repeat { " + this.exe.toString() + " } until (" + this.cond.toString() + ")";
    }
}
