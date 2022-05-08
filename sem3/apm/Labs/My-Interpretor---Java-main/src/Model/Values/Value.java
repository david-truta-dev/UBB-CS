package Model.Values;

import Model.Types.Type;

public interface Value {
    Type getType();
    String toString();
    boolean equals(Object another);
    Value deepCopy();
}
