package Model.Expressions;


import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.Value;

public class NotExp implements Exp{
    private final Exp e;

    public NotExp(Exp e){
        this.e = e;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTbl, MyIDictionary<Integer, Value> heap) throws MyException {
        BoolValue b = (BoolValue)e.eval(symTbl,heap);
        if(b.getValue()) return new BoolValue(false);
        return new BoolValue(true);
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typ=e.typeCheck(typeEnv);
        if (typ.equals(new BoolType())) {
            return new BoolType();
        }else throw new MyException("First operand is not an integer!");
    }

    @Override
    public String toString(){
        return "!" + this.e.toString();
    }

    @Override
    public Exp deepCopy() {
        return new NotExp(this.e);
    }
}
