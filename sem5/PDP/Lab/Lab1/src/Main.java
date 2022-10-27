package ubb.pdp;

import ubb.pdp.Model.Node;
import ubb.pdp.Task.*;

import java.util.ArrayList;
import java.util.Timer;

public class Main {

    public static ArrayList<Node> inputNodes = new ArrayList<>();

    public static void main(String[] args) {
	    createNodes();
	    modifyInputNodes();
	    runChecker();
    }

    private static void modifyInputNodes(){
        //10 threads
        for(int i = 0; i< 10; ++i){
            Timer timer = new Timer();
            timer.schedule(new ModifyInputNodesTask(),0,1000);
        }
    }

    private static void runChecker(){
        Timer timer = new Timer();
        timer.schedule(new RunCheckerTask(),3, 3000);
    }

    private static void createNodes(){
        Node primary1 = new Node(2);
        Node primary2 = new Node(3);
        Node primary3 = new Node(1);
        Node primary4 = new Node(5);
        Node primary5 = new Node(4);
        Node primary6 = new Node(4);

        inputNodes.add(primary1);
        inputNodes.add(primary2);
        inputNodes.add(primary3);
        inputNodes.add(primary4);
        inputNodes.add(primary5);
        inputNodes.add(primary6);

        Node secondSecondary1 = new Node(); //6
        Node secondSecondary2 = new Node(); //8

        //6 = 2+3+1
        primary1.addSecondary(secondSecondary1);
        primary2.addSecondary(secondSecondary1);
        primary3.addSecondary(secondSecondary1);

        //8 = 4+4
        primary5.addSecondary(secondSecondary2);
        primary6.addSecondary(secondSecondary2);

        Node thirdSecondary = new Node(); //19

        //19 = 5+6+8
        primary4.addSecondary(thirdSecondary);
        secondSecondary1.addSecondary(thirdSecondary);
        secondSecondary2.addSecondary(thirdSecondary);

    }
}
