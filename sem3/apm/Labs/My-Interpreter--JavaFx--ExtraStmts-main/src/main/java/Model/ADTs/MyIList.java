package Model.ADTs;

import Exceptions.ListException;
import Model.Values.Value;

import java.util.ArrayList;

public interface MyIList<T> {
    T getElem(int pos) throws ListException;
    int getPosition(T elem) throws ListException;
    boolean isEmpty();
    int size();
    void insert(T elem, int pos) throws ListException;
    void removeByPos(int pos)throws ListException;
    void removeByElem(T elem)throws ListException;
    String toString();
    ArrayList<T> values();
}
