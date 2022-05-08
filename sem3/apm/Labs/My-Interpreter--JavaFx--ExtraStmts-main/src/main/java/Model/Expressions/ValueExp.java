package Model.Expressions;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Types.Type;
import Model.Values.Value;

public class ValueExp implements Exp {
    private final Value val;

    public ValueExp(Value v){
        val = v;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTbl, MyIDictionary<Integer, Value> heap) throws MyException {
        return this.val;
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        return val.getType();
    }

    @Override
    public String toString(){
        return this.val.toString();
    }

    @Override
    public Exp deepCopy() {
        return new ValueExp(this.val.deepCopy());
    }
}
