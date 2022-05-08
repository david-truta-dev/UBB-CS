package Model.Values;

import Model.Types.IntType;
import Model.Types.Type;

public class IntValue implements Value{
    private final int val;

    public IntValue(int v){
        this.val = v;
    }

    public int getValue(){
        return this.val;
    }

    @Override
    public String toString(){
        return Integer.toString(val);
    }

    @Override
    public boolean equals(Object another){
        if(another instanceof IntValue iv){
            return iv.getValue() == this.val;
        }
        return false;
    }

    @Override
    public Type getType() {
        return new IntType();
    }

    @Override
    public Value deepCopy(){
        return new IntValue(val);
    }
}
