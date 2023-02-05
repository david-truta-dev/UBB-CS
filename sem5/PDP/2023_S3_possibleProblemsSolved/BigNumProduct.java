import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class BigNumProduct {

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


    public List<Integer> solve(List<Integer> a, List<Integer> b, int T) throws InterruptedException {
        List<Integer> c = new ArrayList<>();
        int n = a.size();
        int m = 2 * n - 1;
        for (int i = 0; i < m; i++) {
            c.add(0);
        }
        List<Pair<Integer, Integer>> pairs = splitWorkload(m, T);
        List<Thread> threads = new ArrayList<>();
        for (int k = 0; k < T; k++) {
            int finalK = k;
            Thread th = new Thread(() -> {
                for (int x = pairs.get(finalK).getKey(); x < pairs.get(finalK).getValue(); x++) {
                    for (int i = 0; i < n; i++) {
                        if (x - i >= n || x - i < 0) {
                            continue;
                        }
                        c.set(x, c.get(x) + a.get(i) * b.get(x - i));
                    }
                }
            });
            threads.add(th);
        }
        for (Thread t : threads) {
            t.start();
        }
        for (Thread t : threads) {
            t.join();
        }
        List<Integer> result = new ArrayList<>();
        int carry = 0;
        for (int i = c.size() - 1; i >= 0; i--) {
            c.set(i, c.get(i) + carry);
            result.add(c.get(i) % 10);
            if (c.get(i) > 9)
                carry = c.get(i) / 10;
            else carry = 0;
        }
        while (carry > 0) {
            result.add(carry % 10);
            carry /= 10;
        }
        Collections.reverse(result);
        return result;
    }
}