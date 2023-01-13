import java.util.ArrayList;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class HamiltonianCycleFinder {
    public Graph graph;

    public HamiltonianCycleFinder(Graph graph) {
        this.graph = graph;
    }

    public void startSearch() {
        ArrayList<Integer> path = new ArrayList<>();

        //IntStream.range(0, graph.size()).forEach(e -> path.add(-1));

        try {
            //path.set(0, 0);
            path.add(0);
            search(0, path);
        } catch (final Exception e) {
            e.printStackTrace();
        }
    }

    public void search(int currentNode, ArrayList<Integer> path) throws Exception {
        //base case when we found a solution
        //we can reach the first node from the current node and the pathCount is equal to the number of nodes
        if (graph.edgesFromNode(currentNode).contains(0) && path.size() == graph.size()) {
            System.out.println("Solution found:" + path);
            return;
        }
        //if we visited all nodes we just return
        if (path.size() == graph.size()) {
            return;
        }

        //we start checking all possible vertices
        for (int i = 0; i < graph.size(); i++) {

            //if there is an edge to the node and we haven't already visited it
            // we add it to the path and mark it as visited(temporarily remove the edge)
            if (graph.edgesFromNode(currentNode).contains(i) && !checkVisited(i, path)) {

                path.add(i);
                graph.edgesFromNode(currentNode).remove(Integer.valueOf(i));

                //call the search function for this node recursively on a new thread
                ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(4);
                final int node = i;

                final Runnable task = () -> {
                    try {
                        search(node, path);

                    } catch (Exception e) {
                        throw new RuntimeException(e.getMessage());
                    }
                };
                executor.execute(task);

                executor.shutdown();
                executor.awaitTermination(50, TimeUnit.SECONDS);

                //replace the removed edge so the paths can be correctly used
                graph.edgesFromNode(currentNode).add(i);
                //delete the path after it was checked
                path.remove(path.size()-1);

            }

        }
    }

    public boolean checkVisited(int node, ArrayList<Integer> path) {
        for (var n : path)
            if (n == node)
                return true;
        return false;
    }
}