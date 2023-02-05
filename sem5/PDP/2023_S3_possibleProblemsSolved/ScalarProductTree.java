import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class ScalarProductTree {

    //Scalar product of 2 vectors using a tree

    public List<Pair<Integer, Integer>> splitWorkload(int n, int t) {
        List<Pair<Integer, Integer>> pairs = new ArrayList<>();
        int index = 0;
        int step = n / t;
        int mod = n % t;
        while (index < n) {
            int aux;
            if (mod > 0)
                aux = 1;
            else aux = 0;
            pairs.add(new Pair(index, index + step + aux));
            index += step + aux;
            mod--;
        }
        return pairs;
    }

    int leftChild(int index) {
        return 2 * index + 1;
    }

    int rightChild(int index) {
        return 2 * index + 2;
    }

    boolean hasLeftChild(int n, int index) {
        int node = leftChild(index);
        return node >= 0 && node < n;
    }


    boolean hasRightChild(int n, int index) {
        int node = rightChild(index);
        return node >= 0 && node < n;
    }

    public int scalarProduct(List<Integer> a, List<Integer> b, int T) throws InterruptedException {
        List<Integer> c = new ArrayList<>();
        int n = a.size();
        for (int i = 0; i < T; i++) {
            c.add(0);
        }
        List<Pair<Integer, Integer>> pairs = splitWorkload(n, T);

        ExecutorService executorService = Executors.newFixedThreadPool(T);
        for (int i = T - 1; i >= 0; i--) {
            int finalI = i;
            executorService.submit(() -> {
                for (int k = pairs.get(finalI).getKey(); k < pairs.get(finalI).getValue(); k++) {
                    c.set(finalI, c.get(finalI) + a.get(k) * b.get(k));
                }
                if (hasLeftChild(T, finalI)) {
                    c.set(finalI, c.get(finalI) + c.get(leftChild(finalI)));
                }
                if (hasRightChild(T, finalI)) {
                    c.set(finalI, c.get(finalI) + c.get(rightChild(finalI)));
                }
            });
        }
        executorService.shutdown();
        return c.get(0);
    }
}