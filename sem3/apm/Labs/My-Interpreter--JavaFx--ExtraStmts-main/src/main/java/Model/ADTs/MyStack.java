package Model.ADTs;

import Exceptions.StackException;

import java.util.ArrayList;
import java.util.Stack;

public class MyStack<T> implements MyIStack<T>{
    private final Stack<T> stack;

    public MyStack(){
        this.stack = new Stack<>();
    }

    @Override
    public boolean isEmpty() {
        return this.stack.size() == 0;
    }

    @Override
    public T pop() throws StackException{
        if (this.isEmpty())
            throw new StackException("THE STACK IS EMPTY!");
        return this.stack.pop();
    }

    @Override
    public T top() throws StackException {
        if (this.isEmpty())
            throw new StackException("THE STACK IS EMPTY!");
        return this.stack.lastElement();
    }

    @Override
    public void push(T elem){
        this.stack.push(elem);
    }

    @Override
    public ArrayList<T> values() {
        return new ArrayList<>(this.stack.stream().toList());
    }
}
