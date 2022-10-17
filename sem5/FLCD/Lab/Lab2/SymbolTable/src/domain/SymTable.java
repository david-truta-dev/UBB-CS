package domain;

import java.util.HashMap;

public class SymTable<V> {
    HashMap<V, Integer> map = new HashMap<>();

    public void add(V e) {
        map.put(e, map.size());
    }

    public Integer getPos(V e) {
        if (map.containsKey(e)) {
            return map.get(e);
        }
        return null;
    }
}