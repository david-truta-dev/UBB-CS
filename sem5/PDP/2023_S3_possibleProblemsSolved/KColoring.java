import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class KColoring {
    public boolean solved = false;
    public ExecutorService executorService = Executors.newFixedThreadPool(10);
    public Lock lock = new ReentrantLock();
    public List<Integer> colors = new ArrayList<>();

    public boolean isValidColor(int node, int color, boolean[][] matrix, List<Integer> currentColors) {
        for (int i = 0; i < currentColors.size(); i++) {
            if (matrix[node][i] && color == currentColors.get(i)) {
                return false;
            }
        }
        return true;
    }

    public void backtracking(List<Integer> temp, int T, int k, int n, boolean[][] matrix) {
        if (solved) return;
        if (temp.size() == n) {
            lock.lock();
            if (!solved) {
                for (int i = 0; i < n; i++) {
                    colors.add(temp.get(i));
                }
                solved = true;
                executorService.shutdown();
            }
            lock.unlock();
            return;
        }
        if (T == 1) {
            for (int color = 1; color <= k; color++) {
                if (isValidColor(temp.size(), color, matrix, temp)) {
                    temp.add(color);
                    backtracking(temp, T, k, n, matrix);
                    temp.remove(temp.size() - 1);
                }
            }
        } else {
            List<Integer> x = new ArrayList<>(temp);
            executorService.submit(() -> {
                for (int color = 1; color <= k; color += 2) {
                    if (isValidColor(x.size(), color, matrix, x)) {
                        x.add(color);
                        backtracking(x, T / 2, k, n, matrix);
                        x.remove(x.size() - 1);
                    }
                }
            });
            for (int color = 2; color <= k; color += 2) {
                if (isValidColor(temp.size(), color, matrix, temp)) {
                    temp.add(color);
                    backtracking(temp, T - T / 2, k, n, matrix);
                    temp.remove(temp.size() - 1);
                }
            }
        }
    }
}