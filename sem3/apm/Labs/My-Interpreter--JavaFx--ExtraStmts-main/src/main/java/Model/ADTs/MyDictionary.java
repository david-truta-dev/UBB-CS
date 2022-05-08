package Model.ADTs;

import Exceptions.DictionaryException;
import Model.Values.Value;

import java.util.HashMap;
import java.util.Map;

public class MyDictionary<K, V> implements MyIDictionary<K, V>{
    protected Map<K, V> dictionary;

    public MyDictionary() {
        this.dictionary = new HashMap<>();
    }

    @Override
    public Map<K, V> getContent(){
        return this.dictionary;
    }

    @Override
    public void setContent(Map<K, V> unsafeGarbageCollector) {
        //Nothing, since it's not necessary here.
    }

    @Override
    public int size() {
        return this.dictionary.size();
    }

    @Override
    public boolean isEmpty() {
        return this.dictionary.isEmpty();
    }

    @Override
    public boolean isDefined(K key) {
        return this.dictionary.containsKey(key);
    }

    @Override
    public void addElement(K key, V value) throws DictionaryException {
        if (this.isDefined(key))
            throw new DictionaryException("An element with this key already exists");
        this.dictionary.put(key,value);
    }

    @Override
    public void removeElement(K key) throws DictionaryException{
        if (!this.isDefined(key))
            throw new DictionaryException("There is no element with this key");
        this.dictionary.remove(key);
    }

    public V lookup(K key) throws DictionaryException {
        if (!this.isDefined(key))
            throw new DictionaryException("There is no element with this key");
        return this.dictionary.get(key);
    }

    public void update(K key, V value) throws DictionaryException {
        if (!this.isDefined(key))
            throw new DictionaryException("There is no element with this key");
        this.dictionary.replace(key, value);
    }

    @Override
    public V getElem(K key) {
        return this.dictionary.get(key);
    }

    public String toString(){
        return this.dictionary.toString();
    }

    public MyDictionary<K,V> deepCopy(){
        MyDictionary<K,V> newD = new MyDictionary<>();
        this.dictionary.forEach((key, value) -> {
            try {
                if(value instanceof Value v)
                    newD.addElement(key, (V) v.deepCopy());
                else newD.addElement(key, value);
            } catch (DictionaryException ex) {
                ex.printStackTrace();
            }
        });
        return newD;
    }

}
