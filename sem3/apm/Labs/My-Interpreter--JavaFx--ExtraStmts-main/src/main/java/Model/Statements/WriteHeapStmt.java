package Model.Statements;

import Exceptions.DictionaryException;
import Exceptions.MyException;
import Exceptions.WriteHeapException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.RefType;
import Model.Types.Type;
import Model.Values.RefValue;
import Model.Values.Value;

public class WriteHeapStmt implements IStmt{
    private final String varName;
    private final Exp e;

    public WriteHeapStmt(String vn, Exp E) {
        this.varName = vn;
        this.e = E;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        try{
            Value v = state.getSymTable().lookup(varName);
            if(v instanceof RefValue rv){
                try{
                    state.getHeap().lookup(rv.getAddress());
                    Value newV = e.eval(state.getSymTable(), state.getHeap());
                    if(newV.getType().equals(rv.getLocationType())){
                        state.getHeap().update(rv.getAddress(), newV);
                        return null;
                    }
                    else throw new WriteHeapException("The variable's location must have the same type with the value !");
                }catch(DictionaryException ignored){
                    throw new WriteHeapException("There is no value associated with this address :" +
                            rv.getAddress() + "!");
                }
            }
            else throw new WriteHeapException("The variable must be of type RefType!");
        }catch(DictionaryException ignored){
            throw new WriteHeapException("The variable is not declared!");
        }
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        if(typeEnv.lookup(varName).equals(new RefType(e.typeCheck(typeEnv)))){
            return typeEnv;
        }else throw new WriteHeapException("The first parameter is not a reference OR the type of the reference " +
                "and the the type of the second parameter is not the same!");
    }

    @Override
    public IStmt deepCopy() {
        return new WriteHeapStmt(varName, e.deepCopy());
    }

    @Override
    public String toString(){
        return "wH(" + this.varName + ", " + this.e.toString() + ")";
    }
}
