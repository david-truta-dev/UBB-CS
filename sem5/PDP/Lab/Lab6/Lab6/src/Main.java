import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {

        //Hamiltonian cycle: 0->1->2->4->3->0
        Graph graphWithHamiltonianCycle = new Graph(
                new ArrayList<>(List.of(0,1,2,3,4)),
                new ArrayList<>(List.of(
                        new ArrayList<>(List.of(1)),
                        new ArrayList<>(List.of(2, 3)),
                        new ArrayList<>(List.of(4)),
                        new ArrayList<>(List.of(0)),
                        new ArrayList<>(List.of(1, 3, 4))
                )));

        //edge 4->3 is removed, graph no longer contains Hamiltonian cycle
        Graph graphWithoutHamiltonianCycle = new Graph(
                new ArrayList<>(List.of(0,1,2,3,4)),
                new ArrayList<>(List.of(
                        new ArrayList<>(List.of(1)),
                        new ArrayList<>(List.of(2, 3)),
                        new ArrayList<>(List.of(4)),
                        new ArrayList<>(List.of(0)),
                        new ArrayList<>(List.of(1, 4))
                )));

        //random graph, might or might not contain Hamiltonian cycle
        Graph randomGraph = new Graph(10);
        //System.out.println(randomGraph);

        long startTime = System.nanoTime();

        HamiltonianCycleFinder finder = new HamiltonianCycleFinder(graphWithHamiltonianCycle);
        finder.startSearch();

        long stopTime = System.nanoTime();
        double totalTime = ((double) stopTime - (double) startTime) / 1_000_000_000.0;
        System.out.println("Elapsed running time: " + totalTime + "s");
    }
}