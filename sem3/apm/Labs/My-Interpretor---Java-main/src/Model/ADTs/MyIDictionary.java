package Model.ADTs;

import Exceptions.DictionaryException;

import java.util.Map;

public interface MyIDictionary <K,V>{
    int size();
    boolean isEmpty();
    V getElem(K key);
    void addElement(K key, V value) throws DictionaryException;
    boolean isDefined(K key);
    void removeElement(K key) throws DictionaryException;
    V lookup(K id) throws DictionaryException;
    void update(K id, V val) throws DictionaryException;
    String toString();

    Map<K, V> getContent();
    void setContent(Map<K, V> unsafeGarbageCollector);

    MyIDictionary <K,V> deepCopy();
}
