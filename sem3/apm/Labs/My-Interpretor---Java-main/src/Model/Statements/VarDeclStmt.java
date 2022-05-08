package Model.Statements;


import Exceptions.MyException;
import Exceptions.VarDeclException;
import Model.ADTs.MyIDictionary;
import Model.PrgState;
import Model.Types.Type;


public class VarDeclStmt implements IStmt{
    private final String name;
    private final Type typ;

    public VarDeclStmt(String n, Type t){
        this.name = n;
        this.typ = t;
    }

    public PrgState execute(PrgState state) throws MyException {
        try{
            state.getSymTable().lookup(this.name);
            throw new VarDeclException("Variable '"+ this.name +"' has already been declared!");
        }catch(MyException e){
            state.getSymTable().addElement(name, this.typ.defaultValue());
        }
        return null;
    }

    @Override
    public String toString(){
        return this.typ.toString() +" "+ this.name;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        typeEnv.addElement(name,typ);
        return typeEnv;
    }

    @Override
    public IStmt deepCopy() {
        return new VarDeclStmt(this.name, this.typ);
    }
}
