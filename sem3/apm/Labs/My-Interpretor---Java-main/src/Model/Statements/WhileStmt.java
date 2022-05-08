package Model.Statements;

import Exceptions.MyException;
import Exceptions.WhileStmtException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;

public class WhileStmt implements IStmt {
    private final Exp cond;
    private final IStmt exe;

    public WhileStmt(Exp c, IStmt e){
        this.cond = c;
        this.exe = e;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        if(this.cond.eval(state.getSymTable(), state.getHeap()) instanceof BoolValue c){
            if(c.getValue()){
                state.getStk().push(this);
                exe.execute(state);
            }
            return null;
        }
        else throw new WhileStmtException("The condition in While stmt should be a BoolType!");
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typExp=cond.typeCheck(typeEnv);
        if (typExp.equals(new BoolType())) {
            exe.typeCheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else throw new MyException("The condition of WHILE doesn't have the type bool!");
    }

    @Override
    public IStmt deepCopy() {
        return new WhileStmt(this.cond.deepCopy(), this.exe.deepCopy());
    }

    @Override
    public String toString(){
        return "while(" + this.cond.toString() + ") { " + this.exe.toString() + " }";
    }
}
