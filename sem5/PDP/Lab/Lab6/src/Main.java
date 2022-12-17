import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Main {

    public static void main(String[] args) throws InterruptedException {

        int GRAPHS_COUNT = 100;

        List<DirectedGraph> graphs = new ArrayList<>();

        for (int i = 1; i <= GRAPHS_COUNT+1; i++) {
            graphs.add(new DirectedGraph(i*10));
        }

        System.out.println("Sequential");
        test(1, graphs.get(1), 1);
        test(50, graphs.get(50), 50);
        test(100, graphs.get(100), 100);

        System.out.println("Parallel");
        test(1, graphs.get(1), 5);
        test(50, graphs.get(50), 5);
        test(100, graphs.get(100), 5);

    }

    private static void test(int testSize, DirectedGraph graph, int threadCount) throws InterruptedException {
        long startTime = System.nanoTime();
        findHamiltonian(graph, threadCount);
        long endTime = System.nanoTime();
        long duration = (endTime - startTime) / 1000000;
        System.out.println("Size " + testSize*10 + ": " + duration + " ms");
    }

    private static void findHamiltonian(DirectedGraph graph, int threadCount) throws InterruptedException {
        ExecutorService pool = Executors.newFixedThreadPool(threadCount);
        Lock lock = new ReentrantLock();
        List<Integer> result = new ArrayList<>(graph.size());

        for (int i = 0; i < graph.size(); i++){
            pool.execute(new Task(graph, i, result, lock));
        }

        pool.shutdown();
        pool.awaitTermination(10, TimeUnit.SECONDS);
    }

}
