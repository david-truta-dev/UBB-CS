package ubb.pdp.Model;

import java.util.ArrayList;
import java.util.concurrent.locks.ReentrantLock;

public class Node {
    public ReentrantLock mutex = new ReentrantLock();

    private ArrayList<Node> inputs = new ArrayList<>();
    private ArrayList<Node> secondary = new ArrayList<>(); //sum nodes
    private int value = 0;

    public Node (int value){
        this.value = value;
    }

    public Node() {}

    public ArrayList<Node> getInputs() {
        return inputs;
    }

    public ArrayList<Node> getSecondary() {
        return secondary;
    }

    public int getValue() {
        return value;
    }


    public void addSecondary(Node secondary){
        this.secondary.add(secondary);
        secondary.addInput(this);
        secondary.addValue(value);
    }

    public void addInput(Node input){
        this.inputs.add(input);
    }


    public void addValue(int value){
        mutex.lock();

        this.value += value;
        this.getSecondary().forEach(secondary ->
                secondary.addValue(value)
        );

        mutex.unlock();
    }
}
