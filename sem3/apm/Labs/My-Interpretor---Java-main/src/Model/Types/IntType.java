package Model.Types;

import Model.Values.IntValue;
import Model.Values.Value;

public class IntType implements Type{

    @Override
    public Value defaultValue() {
        return new IntValue(0);
    }

    @Override
    public String toString() {
        return "int";
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof IntType;
    }
}
