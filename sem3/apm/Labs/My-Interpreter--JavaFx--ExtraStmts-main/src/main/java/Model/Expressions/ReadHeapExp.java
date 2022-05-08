package Model.Expressions;

import Exceptions.DictionaryException;
import Exceptions.MyException;
import Exceptions.ReadHeapException;
import Model.ADTs.MyIDictionary;
import Model.Types.RefType;
import Model.Types.Type;
import Model.Values.RefValue;
import Model.Values.Value;

public class ReadHeapExp implements Exp{
    private final Exp e;

    public ReadHeapExp(Exp E){
        this.e = E;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTbl, MyIDictionary<Integer, Value> heap) throws MyException {
        if(e.eval(symTbl, heap) instanceof RefValue rv){
            try{
                return heap.lookup(rv.getAddress());
            }catch (DictionaryException ignored){
                throw new ReadHeapException("The memory at address '" + rv.getAddress() + "' is not allocated!" );
            }
        }
        else throw new ReadHeapException("Argument must be of type RefValue!");
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
         Type typ=e.typeCheck(typeEnv);
         if (typ instanceof RefType refT) {
             return refT.getInner();
         } else throw new MyException("the rH argument is not a Ref Type");
    }

    @Override
    public String toString(){
        return "rH(" + e.toString() + ")";
    }

    @Override
    public Exp deepCopy() {
        return new ReadHeapExp(e.deepCopy());
    }
}
