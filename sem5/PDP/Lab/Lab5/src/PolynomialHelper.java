import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class PolynomialHelper {

    public static Polynomial multiplicationSequentialForm(Polynomial p1, Polynomial p2) {
        int sizeOfResultCoefficientList = p1.getDegree() + p2.getDegree() + 1;

        List<Integer> coefficients = new ArrayList<>();

        for (int i = 0; i < sizeOfResultCoefficientList; i++) {
            coefficients.add(0);
        }

        for (int i = 0; i < p1.getCoefficients().size(); i++) {
            for (int j = 0; j < p2.getCoefficients().size(); j++) {
                int index = i + j;
                int value = p1.getCoefficients().get(i) * p2.getCoefficients().get(j);
                coefficients.set(index, coefficients.get(index) + value);
            }
        }
        return new Polynomial(coefficients);
    }

    public static Polynomial multiplicationParallelizedForm(Polynomial p1, Polynomial p2, int nrOfThreads) throws InterruptedException {
        int sizeOfResultCoefficientList = p1.getDegree() + p2.getDegree() + 1;

        List<Integer> coefficients = IntStream.of(new int[sizeOfResultCoefficientList]).boxed().collect(Collectors
                .toList());
        Polynomial result = new Polynomial(coefficients);

        ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(nrOfThreads);
        int step = result.getLength() / nrOfThreads;
        if (step == 0) {
            step = 1;
        }

        int end;
        for (int i = 0; i < result.getLength(); i += step) {
            end = i + step;
            PolynomialTask polynomialTask = new PolynomialTask(i, end, p1, p2, result);
            executor.execute(polynomialTask);
        }

        executor.shutdown();
        executor.awaitTermination(50, TimeUnit.SECONDS);

        return result;
    }

    public static Polynomial multiplicationKaratsubaSequentialForm(Polynomial p1, Polynomial p2) {
        if (p1.getDegree() < 2 || p2.getDegree() < 2) {
            return multiplicationSequentialForm(p1, p2);
        }

        int mid = Math.max(p1.getDegree(), p2.getDegree()) / 2;

        Polynomial lowP1 = new Polynomial(p1.getCoefficients().subList(0, mid));
        Polynomial highP1 = new Polynomial(p1.getCoefficients().subList(mid, p1.getLength()));
        Polynomial lowP2 = new Polynomial(p2.getCoefficients().subList(0, mid));
        Polynomial highP2 = new Polynomial(p2.getCoefficients().subList(mid, p2.getLength()));

        Polynomial z1 = multiplicationKaratsubaSequentialForm(lowP1, lowP2); // p2 * q2
        Polynomial z2 = multiplicationKaratsubaSequentialForm(add(lowP1, highP1), add(lowP2, highP2)); // (p1 + p2) * (q1 + q2)
        Polynomial z3 = multiplicationKaratsubaSequentialForm(highP1, highP2); // p1 * q1

        //calculate the final result
        Polynomial r1 = shift(z3, 2 * mid); // z3 * x^2n
        Polynomial r2 = shift(subtract(subtract(z2, z3), z1), mid); // (z2 - z3 - z1) * x^n
        return add(add(r1, r2), z1);
    }

    public static Polynomial multiplicationKaratsubaParallelizedForm(Polynomial p1, Polynomial p2, int currentDepth) throws ExecutionException, InterruptedException {
        if (currentDepth > 3) {
            return multiplicationKaratsubaSequentialForm(p1, p2);
        }
        if (p1.getDegree() < 2 || p2.getDegree() < 2) {
            return multiplicationKaratsubaSequentialForm(p1, p2);
        }

        int len = Math.max(p1.getDegree(), p2.getDegree()) / 2;

        Polynomial lowP1 = new Polynomial(p1.getCoefficients().subList(0, len));
        Polynomial highP1 = new Polynomial(p1.getCoefficients().subList(len, p1.getLength()));
        Polynomial lowP2 = new Polynomial(p2.getCoefficients().subList(0, len));
        Polynomial highP2 = new Polynomial(p2.getCoefficients().subList(len, p2.getLength()));

        ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newCachedThreadPool();
        Callable<Polynomial> task1 = () -> multiplicationKaratsubaParallelizedForm(lowP1, lowP2, currentDepth + 1);
        Callable<Polynomial> task2 = () -> multiplicationKaratsubaParallelizedForm(PolynomialHelper.add(lowP1, highP1), PolynomialHelper.add(lowP2, highP2), currentDepth + 1);
        Callable<Polynomial> task3 = () -> multiplicationKaratsubaParallelizedForm(highP1, highP2, currentDepth + 1);

        Future<Polynomial> f1 = executor.submit(task1);
        Future<Polynomial> f2 = executor.submit(task2);
        Future<Polynomial> f3 = executor.submit(task3);

        executor.shutdown();

        Polynomial z1 = f1.get();
        Polynomial z2 = f2.get();
        Polynomial z3 = f3.get();

        executor.awaitTermination(60, TimeUnit.SECONDS);

        // compute the final result
        Polynomial r1 = shift(z3, 2 * len);
        Polynomial r2 = shift(subtract(subtract(z2, z3), z1), len);
        return add(add(r1, r2), z1);
    }

    public static Polynomial shift(Polynomial p, int offset) {
        List<Integer> coefficients = new ArrayList<>();
        for (int i = 0; i < offset; i++) {
            coefficients.add(0);
        }
        for (int i = 0; i < p.getLength(); i++) {
            coefficients.add(p.getCoefficients().get(i));
        }
        return new Polynomial(coefficients);
    }

    public static Polynomial add(Polynomial p1, Polynomial p2) {
        int minDegree = Math.min(p1.getDegree(), p2.getDegree());
        int maxDegree = Math.max(p1.getDegree(), p2.getDegree());
        List<Integer> coefficients = new ArrayList<>(maxDegree + 1);

        // Add the 2 polynomials
        for (int i = 0; i <= minDegree; i++) {
            coefficients.add(p1.getCoefficients().get(i) + p2.getCoefficients().get(i));
        }

        addRemainingCoefficients(p1, p2, minDegree, maxDegree, coefficients);

        return new Polynomial(coefficients);
    }

    private static void addRemainingCoefficients(Polynomial p1, Polynomial p2, int minDegree, int maxDegree,
                                                 List<Integer> coefficients) {
        if (minDegree != maxDegree) {
            if (maxDegree == p1.getDegree()) {
                for (int i = minDegree + 1; i <= maxDegree; i++) {
                    coefficients.add(p1.getCoefficients().get(i));
                }
            } else {
                for (int i = minDegree + 1; i <= maxDegree; i++) {
                    coefficients.add(p2.getCoefficients().get(i));
                }
            }
        }
    }

    public static Polynomial subtract(Polynomial p1, Polynomial p2) {
        int minDegree = Math.min(p1.getDegree(), p2.getDegree());
        int maxDegree = Math.max(p1.getDegree(), p2.getDegree());
        List<Integer> coefficients = new ArrayList<>(maxDegree + 1);

        // Subtract the 2 polynomials
        for (int i = 0; i <= minDegree; i++) {
            coefficients.add(p1.getCoefficients().get(i) - p2.getCoefficients().get(i));
        }

        addRemainingCoefficients(p1, p2, minDegree, maxDegree, coefficients);

        // Remove coefficients starting from the biggest power if coefficient is 0

        int i = coefficients.size() - 1;
        while (coefficients.get(i) == 0 && i > 0) {
            coefficients.remove(i);
            i--;
        }

        return new Polynomial(coefficients);
    }
}
