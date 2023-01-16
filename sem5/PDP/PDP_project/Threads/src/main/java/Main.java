import graph.ColorsGraph;
import graph.DirectedGraph;
import graph.GraphColoring;
import graph.GraphColoringException;

public class Main {

    public static void main(String[] args) {
        System.out.println("APP STARTED...\n");

        DirectedGraph graph = new DirectedGraph(5);
        graph.addVertex(0,1);
        graph.addVertex(1,2);
        graph.addVertex(2,3);
        graph.addVertex(3,4);
        graph.addVertex(4,0);
        graph.addVertex(2,0);
        graph.addVertex(0,4);
        graph.addVertex(4,3);
        graph.addVertex(3,1);
        graph.addVertex(4, 1);

        ColorsGraph colors = new ColorsGraph(3);
        colors.addCodeToColor(0, "red");
        colors.addCodeToColor(1, "green");
        colors.addCodeToColor(2, "blue");
//        colors.addCodeToColor(3, "yellow");
//        colors.addCodeToColor(4, "pink");
//        colors.addCodeToColor(5, "black");

        int threadsNo = 10;

        try {
            System.out.println(GraphColoring.getGraphColoring(threadsNo, graph, colors));
        } catch (GraphColoringException gce) {
            System.out.println(gce);
        }

        System.out.println("\nAPP STOPPED.");
    }
}
