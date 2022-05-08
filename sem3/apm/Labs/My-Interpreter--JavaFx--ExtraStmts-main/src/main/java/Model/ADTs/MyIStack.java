package Model.ADTs;

import Exceptions.StackException;

import java.util.ArrayList;

public interface MyIStack<T>{
    void push(T elem);
    T pop() throws StackException;
    boolean isEmpty();
    T top() throws StackException;
    ArrayList<T> values();
}
