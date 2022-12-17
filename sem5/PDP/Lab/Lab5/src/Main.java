import java.util.ArrayList;
import java.util.concurrent.ExecutionException;

public class Main {
    public static void main(String[] args) throws InterruptedException, ExecutionException {

        Polynomial p = new Polynomial(10000);
        Polynomial q = new Polynomial(10000);

        System.out.println("p:" + p);
        System.out.println("q:" + q);


//        System.out.println(classicSequentialMultiplication(p, q));
//        System.out.println(classicParallelMultiplication(p, q));

//        System.out.println(KaratsubaSequentialMultiplication(p, q));
//        System.out.println(KaratsubaParallelMultiplication(p, q));

        classicSequentialMultiplication(p, q);
        classicParallelMultiplication(p, q);

        KaratsubaSequentialMultiplication(p, q);
        KaratsubaParallelMultiplication(p, q);

    }

    private static Polynomial classicSequentialMultiplication(Polynomial p, Polynomial q) {
        long startTime = System.nanoTime();
        Polynomial result = PolynomialHelper.multiplicationSequentialForm(p, q);
        long endTime = System.nanoTime();
        System.out.println("Simple seq: ");
        System.out.print("Time: ");
        System.out.println((endTime - startTime) / 1000000);
        return result;
    }

    private static Polynomial classicParallelMultiplication(Polynomial p, Polynomial q) throws InterruptedException {
        long startTime = System.nanoTime();
        Polynomial result = PolynomialHelper.multiplicationParallelizedForm(p, q, 2);
        long endTime = System.nanoTime();
        System.out.println("Simple parallel: ");
        System.out.print("Time: ");
        System.out.println((endTime - startTime) / 1000000);
        return result;
    }

    private static Polynomial KaratsubaSequentialMultiplication(Polynomial p, Polynomial q) {
        long startTime = System.nanoTime();
        Polynomial result = PolynomialHelper.multiplicationKaratsubaSequentialForm(p, q);
        long endTime = System.nanoTime();
        System.out.println("Karatsuba seq: ");
        System.out.print("Time: ");
        System.out.println((endTime - startTime) / 1000000);
        return result;
    }

    private static Polynomial KaratsubaParallelMultiplication(Polynomial p, Polynomial q) throws ExecutionException,
            InterruptedException {
        long startTime = System.nanoTime();
        Polynomial result = PolynomialHelper.multiplicationKaratsubaParallelizedForm(p, q, 1);
        long endTime = System.nanoTime();
        System.out.println("Karatsuba parallel: ");
        System.out.print("Time: ");
        System.out.println((endTime - startTime) / 1000000);
        return result;
    }
}
