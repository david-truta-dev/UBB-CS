import java.util.*;
import java.util.concurrent.CyclicBarrier;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Main {

    static int NR_THREADS = 4;
    public static void main(String[] args) throws InterruptedException {

        Graph graph = new Graph("g2.txt");
        //Graph graph = new Graph(500, 100);

        color(graph);
    }

    public static List<Thread> createThreads(Graph graph, Set<Integer> conflicting){
        int n = graph.getNrNodes();

        int nodesPerThread = n / NR_THREADS;

        CyclicBarrier barrier = new CyclicBarrier(NR_THREADS);

        List<Thread> threads = new ArrayList<>();
        for(int i = 0; i < NR_THREADS; i++){
            int start = i * nodesPerThread;
            int end = start + nodesPerThread;
            if(i == NR_THREADS - 1){
                end = n;
            }
            Runnable thread = new ColoringThread(graph, start, end, barrier, conflicting);
            threads.add(new Thread(thread));
        }

        return threads;
    }

    public static void color(Graph graph){
        Set<Integer> conflicting = IntStream.rangeClosed(0, graph.getNrNodes()).boxed().collect(Collectors.toSet());

        while (! conflicting.isEmpty()){
            Set<Integer> newConflicting = new HashSet<>();
            List<Thread> threads = createThreads(graph, newConflicting);
            for(var t: threads){
                t.start();
            }
            for(var t: threads){
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
