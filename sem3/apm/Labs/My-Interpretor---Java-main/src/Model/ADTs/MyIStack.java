package Model.ADTs;

import Exceptions.StackException;

public interface MyIStack<T>{
    void push(T elem);
    T pop() throws StackException;
    boolean isEmpty();
    T top() throws StackException;
}
