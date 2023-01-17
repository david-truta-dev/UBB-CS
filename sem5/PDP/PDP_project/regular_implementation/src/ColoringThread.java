import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

public class ColoringThread implements Runnable{

    Graph graph;
    int start;
    int end;
    CyclicBarrier barrier;
    Set<Integer> conflicting;

    public ColoringThread(Graph graph, int start, int end, CyclicBarrier barrier, Set<Integer> conflicting) {
        this.graph = graph;
        this.start = start;
        this.end = end;
        this.barrier = barrier;
        this.conflicting = conflicting;
    }

    @Override
    public void run() {
        // phase 1: coloring
        for(int i = start; i < end; i++){
            Set<Integer> forbiddenColors = new HashSet<>();

            Node currentNode = graph.getNode(i);
            for(int neighbour: currentNode.getNeighbours()){
                forbiddenColors.add(graph.getNode(neighbour).getColor());
            }

            int leastAvailableColor = 0;
            while(forbiddenColors.contains(leastAvailableColor)){
                leastAvailableColor++;
            }

            currentNode.setColor(leastAvailableColor);
        }


        try {
            barrier.await();
        } catch (InterruptedException | BrokenBarrierException e) {
            e.printStackTrace();
        }

        // phase 2: conflict detection, creating the set with the nodes needing to be recolored
        for(int i = start; i < end; i++) {

            Node currentNode = graph.getNode(i);
            for(int neighbour: currentNode.getNeighbours()){
                if(currentNode.getColor() == graph.getNode(neighbour).getColor()){
                    conflicting.add(Math.max(i, neighbour));
                }
            }
        }

        try {
            barrier.await();
        } catch (InterruptedException | BrokenBarrierException e) {
            e.printStackTrace();
        }
    }
}
