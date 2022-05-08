package Model.Types;

import Model.Values.RefValue;
import Model.Values.Value;

public class RefType implements Type{
    private final Type inner;

    public RefType (Type in){ this.inner = in;}

    public Type getInner(){
        return this.inner;
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof RefType) return inner.equals(((RefType) o).getInner());
        else return false;
    }

    @Override
    public Value defaultValue() {
        return new RefValue(0, inner);
    }

    public String toString(){
        return "Ref(" + inner.toString() + ")";
    }
}
