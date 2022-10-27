package ubb.pdp.Checker;

import ubb.pdp.Model.Node;

import java.util.ArrayList;
import java.util.concurrent.atomic.AtomicBoolean;

public class Checker {
    private ArrayList<Node> inputNodes;

    public Checker(ArrayList<Node> inputNodes) {
        this.inputNodes = inputNodes;
    }

    public boolean run() {
        lockNodes();
        boolean isValid = checkNodes();
        unlockNodes();

        return isValid;
    }

    public void lockNodes() {
        inputNodes.forEach(node -> {
            node.mutex.lock();
            lockSecondary(node);
        });
    }

    public void lockSecondary(Node node) {
        node.getSecondary().forEach(secondary -> {
            secondary.mutex.lock();
            lockSecondary(secondary);
        });
    }

    public boolean checkNodes() {
        AtomicBoolean isValid = new AtomicBoolean(true);

        inputNodes.forEach(node -> {
            if(!check(node)) isValid.set(false);
        });

        return isValid.get();
    }

    public boolean check(Node node) {
        AtomicBoolean isValid = new AtomicBoolean(true);

        if(node.getSecondary().size() != 0) {
            if (node.getInputs().size() != 0) {
                int sumValue = node.getInputs().stream().map(Node::getValue).reduce(0, Integer::sum);
                isValid.set(sumValue == node.getValue());
            }
            if(isValid.get()) {
                node.getSecondary().forEach(secondary -> {
                    if(!check(secondary)) isValid.set(false);
                });
            }
        }
        //System.out.println(node.getValue()+" "+isValid.get());
        return isValid.get();
    }

    public void unlockNodes() {
        inputNodes.forEach(node -> {
            node.mutex.unlock();
            unlockSecondary(node);
        });
    }

    public void unlockSecondary(Node node) {
        node.getSecondary().forEach(secondary -> {
            secondary.mutex.unlock();
            unlockSecondary(secondary);
        });
    }
}
