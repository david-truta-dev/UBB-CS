package Model.Expressions;

import Exceptions.MyException;
import Exceptions.VarExpException;
import Model.ADTs.MyIDictionary;
import Model.Types.Type;
import Model.Values.Value;

public class VarExp implements Exp{
    private final String name;

    public VarExp(String n){
        this.name = n;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTbl, MyIDictionary<Integer, Value> heap) throws MyException {
        Value v = symTbl.getElem(this.name);
        if (v == null)
            throw new VarExpException("The Variable is not declared!");
        return v;
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        return typeEnv.lookup(name);
    }

    @Override
    public String toString(){
        return this.name;
    }

    @Override
    public Exp deepCopy() {
        return new VarExp(this.name);
    }
}