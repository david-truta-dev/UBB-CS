package Model.ADTs;

import java.util.Map;

public class Heap<K,V> extends MyDictionary<K,V>{
    private int freeAddrLoc;

    public Heap(){
        super();
        this.freeAddrLoc = 1;
    }

    public void setContent(Map<K, V> garbageCollector){
        this.dictionary = garbageCollector;
    }

    public Map<K, V> getContent(){
        return this.dictionary;
    }

    public int getFreeAddrLoc() {
        return freeAddrLoc;
    }

    public void generateNewAddr(){
        this.freeAddrLoc +=1 ;
    }
}
