package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.Type;
import Model.Values.Value;

public class AssignStmt implements IStmt {
    private final String id;
    private final Exp exp;

    public AssignStmt(String i, Exp e){
        this.id = i;
        this.exp = e;
    }

    @Override
    public String toString(){
        return id+"="+exp.toString();
    }

    public PrgState execute(PrgState state) throws MyException {
        if (state.getSymTable().isDefined(id)) {
            Value val = exp.eval(state.getSymTable(), state.getHeap());
            Type typId = (state.getSymTable().lookup(id)).getType();
            if (val.getType().equals(typId))
                state.getSymTable().update(id, val);
            else throw new MyException("Declared type of variable '" + id + "' and type of  the assigned expression do not match!");
        }
        else throw new MyException("The used variable '" + id + "' wasn't declared!");
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typeVar = typeEnv.lookup(id);
        Type typExp = exp.typeCheck(typeEnv);
        if (typeVar.equals(typExp))
            return typeEnv;
        else throw new MyException("Assignment: right hand side and left hand side have different types ");
    }

    @Override
    public IStmt deepCopy() {
        return new AssignStmt(this.id, this.exp);
    }
}
