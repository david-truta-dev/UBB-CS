import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicInteger;

public class KPermutations {

    public AtomicInteger cnt;
    public ExecutorService executorService = Executors.newFixedThreadPool(10);

    public KPermutations() {
        cnt = new AtomicInteger(0);
    }

    public boolean pred(List<Integer> v) {
        return true;
    }

    public void back(List<Integer> sol, int T, int n, int k) {
        if (sol.size() == k) {
            if (pred(sol)) {
                cnt.getAndIncrement();
            }
            return;
        }
        if (T == 1) {
            for (int i = 1; i <= n; i++) {
                if (sol.contains(i)) continue;
                List<Integer> copy = new ArrayList<>(sol);
                copy.add(i);
                back(copy, T, n, k);
            }
        } else {
            int threads = Math.min(T, n - sol.size());
            List<List<Integer>> copies = new ArrayList<>();
            for (int i = 1; i <= n; i++) {
                if (sol.contains(i)) continue;
                copies.add(new ArrayList<>(sol));
            }
            for (int i = 0; i < copies.size(); i++) {
                final int j = i;
                executorService.submit(() -> {
                    copies.get(j).add(j + 1);
                    back(copies.get(j), T / threads, n, k);
                });
            }
        }
    }
}