package Model.Statements;

import Exceptions.DictionaryException;
import Exceptions.HeapDeclException;
import Exceptions.MyException;
import Model.ADTs.Heap;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.RefType;
import Model.Types.Type;
import Model.Values.RefValue;
import Model.Values.Value;

public class NewStmt implements IStmt{
    private final String varName;
    private final Exp e;

    public NewStmt(String vn, Exp E){
        this.varName = vn;
        this.e = E;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        try{
            Value varVal = state.getSymTable().lookup(varName);
            if(varVal instanceof RefValue rVal){
                Value v = e.eval(state.getSymTable(), state.getHeap());
                if(v.getType().equals(rVal.getLocationType())){
                    int freeAddressLocation = ((Heap<Integer, Value>) state.getHeap()).getFreeAddrLoc();
                    ((Heap<Integer, Value>) state.getHeap()).generateNewAddr();
                    state.getHeap().addElement(freeAddressLocation, v);
                    state.getSymTable().update(varName, new RefValue(freeAddressLocation, rVal.getLocationType()));
                    return null;
                }
                else throw new HeapDeclException("The RefType must have the same locationType!");
            }
            else throw new HeapDeclException("The variable must be a RefType!");
        }catch (DictionaryException ignored){
            throw new HeapDeclException("There is no reference with this name!");
        }
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typeVar = typeEnv.lookup(varName);
        Type typExp = e.typeCheck(typeEnv);
        if (typeVar.equals(new RefType(typExp)))
            return typeEnv;
        else throw new MyException("NEW stmt: right hand side and left hand side have different types ");
    }

    @Override
    public String toString(){
        return "new(" + this.varName + ", " + this.e.toString() + ")" ;
    }

    @Override
    public IStmt deepCopy() {
        return new NewStmt(this.varName, e.deepCopy());
    }
}
