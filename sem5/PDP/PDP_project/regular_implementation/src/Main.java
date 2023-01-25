import java.util.*;
import java.util.concurrent.CyclicBarrier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Main {

    static int NR_THREADS = 4;

    public static void main(String[] args) throws InterruptedException {

        Graph graph = new Graph("g2.txt");
//        graph = new Graph(500, 100);

        long startTime = System.nanoTime();
        color(graph);
        long endTime = System.nanoTime();

        long duration = (endTime - startTime) / 1000000;
        System.out.printf("Execution took: %d ms", duration);
    }

    public static List<Thread> createThreads(Graph graph, Set<Integer> conflicting) {
        int n = graph.getNrNodes();

        int nodesPerThread = n / NR_THREADS;
        int remaining = n % NR_THREADS;

        CyclicBarrier barrier = new CyclicBarrier(NR_THREADS);

        List<Thread> threads = new ArrayList<>();

        int endOfLastT = 0;
        int start;
        for (int i = 0; i < NR_THREADS; i++) {
            start = endOfLastT;
            int end;
            if (remaining > 0) {
                end = start + nodesPerThread + 1;
                remaining--;
            } else {
                end = start + nodesPerThread;
            }
            endOfLastT = end;
            Runnable thread = new ColoringThread(graph, start, end, barrier, conflicting);
            threads.add(new Thread(thread));
        }

        return threads;
    }

    public static void color(Graph graph) {
        Set<Integer> conflicting = new HashSet<>();
        conflicting.add(1);

        while (!conflicting.isEmpty()) {
            Set<Integer> newConflicting = new HashSet<>();
            List<Thread> threads = createThreads(graph, newConflicting);
            for (var t : threads) {
                t.start();
            }
            for (var t : threads) {
                try {
                    t.join();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
            conflicting = newConflicting;
        }

        System.out.println(graph);
        System.out.println(graph.checkColoring());
    }
}
