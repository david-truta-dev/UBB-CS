package Model.Types;

import Model.Values.Value;

public interface Type {
    Value defaultValue();
    boolean equals(Object another);
    String toString();

}
