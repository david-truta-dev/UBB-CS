package Model.Values;

import Model.Types.RefType;
import Model.Types.Type;

public class RefValue implements Value{
    private final int address;
    private final Type locationType;

    public RefValue(int  addr, Type locT){
        this.address = addr;
        this.locationType = locT;
    }

    public int getAddress(){
        return this.address;
    }

    public Type getLocationType(){
        return this.locationType;
    }

    @Override
    public Type getType() {
        return new RefType(this.locationType);
    }

    @Override
    public Value deepCopy() {
        return new RefValue(this.address, this.locationType);//DEEP COPY OF LOCATION?
    }

    @Override
    public String toString() {
        return "(" + address + ", " + locationType.toString() + ')';
    }

    @Override
    public boolean equals(Object o) {
        if (o instanceof RefValue && this.address == ((RefValue) o).address){
            return this.locationType.equals(((RefValue) o).locationType);
        }
        return false;
    }

}
