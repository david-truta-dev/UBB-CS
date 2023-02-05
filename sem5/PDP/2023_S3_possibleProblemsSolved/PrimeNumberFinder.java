import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.locks.ReentrantLock;

//Prime Numbers up to n

class PrimeNumberTask implements Runnable {
    private final int start;
    private final int end;
    private final ReentrantLock mutex;
    private final List<Integer> primes;
    private final List<Integer> result;

    public PrimeNumberTask(int start, int end, ReentrantLock mutex, List<Integer> primes, List<Integer> result) {
        this.start = start;
        this.end = end;
        this.primes = primes;
        this.result = result;
        this.mutex = mutex;
    }

    public void run() {
        for (int i = start; i <= end; i++) {
            boolean isPrime = true;
            for (int prime : primes) {
                if (i % prime == 0) {
                    isPrime = false;
                    break;
                }
            }
            if (isPrime) {
                mutex.lock();
                result.add(i);
                mutex.unlock();
            }
        }
    }
}

public class PrimeNumberFinder {
    public static List<Integer> findPrimes(int n, ArrayList<Integer> primesToSquareRoot) throws InterruptedException, ExecutionException {
        int numThreads = 4;
        ExecutorService executor = Executors.newFixedThreadPool(numThreads);
        ReentrantLock mutex = new ReentrantLock();
        ArrayList<Integer> restOfPrimes = new ArrayList<>();
        List<Future> futures = new ArrayList<>();

        int start = 3;
        int step = (n - 2) / numThreads;
        for (int i = 0; i < numThreads; i++) {
            int end = Math.min(start + step, n);
            futures.add(executor.submit(new PrimeNumberTask(start, end, mutex, primesToSquareRoot, restOfPrimes)));

            start = end + 1;
        }

        for (Future future : futures) {
            future.get();
        }

        executor.shutdown();

        primesToSquareRoot.addAll(restOfPrimes);
        return primesToSquareRoot;
    }
}