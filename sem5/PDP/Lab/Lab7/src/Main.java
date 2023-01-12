import domain.Polynomial;
import domain.Product;
import mpi.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    private static final String APPROACH = "Simple";
    private static final int ORDER = 10;

    public static void main(String[] args) {
        MPI.Init(args);
        int me = MPI.COMM_WORLD.Rank();
        int nrProcs = MPI.COMM_WORLD.Size();
        if (me == 0) {
            // master process
            System.out.println("Master process generating polynomials:");
            Polynomial a = new Polynomial(ORDER);
            Polynomial b = new Polynomial(ORDER);

            System.out.println(a);
            System.out.println(b);

            multiplicationMaster(a, b, nrProcs);
        } else {
            if (APPROACH.equals("Karatsuba")){
                multiplyKaratsubaWorker(me);
            }
            else{
                multiplySimpleWorker(me);
            }
        }
        MPI.Finalize();
    }

    private static void multiplicationMaster(Polynomial a, Polynomial b, int nrProcs) {
        long startTime = System.currentTimeMillis();
        int start = 0, finish = 0;
        int len = a.getSize() / (nrProcs - 1);

        for (int i = 1; i < nrProcs; i++) {
            start = finish;
            finish += len;
            if (i == nrProcs - 1) {
                finish = a.getSize();
            }

            MPI.COMM_WORLD.Send(new Object[]{a.getCoefficients().toString().substring(1, a.getCoefficients().toString().length() - 1)}, 0, 1, MPI.OBJECT, i, 0);
            MPI.COMM_WORLD.Send(new Object[]{b.getCoefficients().toString().substring(1, b.getCoefficients().toString().length() - 1)}, 0, 1, MPI.OBJECT, i, 0);

            MPI.COMM_WORLD.Send(new int[]{start}, 0, 1, MPI.INT, i, 0);
            MPI.COMM_WORLD.Send(new int[]{finish}, 0, 1, MPI.INT, i, 0);
        }

        Object[] objResults = new Object[nrProcs - 1];
        for (int i = 1; i < nrProcs; i++) {
            MPI.COMM_WORLD.Recv(objResults, i - 1, 1, MPI.OBJECT, i, 0);
        }

        ArrayList<Polynomial> results = new ArrayList<>();

        for(int i = 0; i < nrProcs - 1; ++i) {
            results.add(new Polynomial(createCoefficientList(objResults, i)));
        }

        Polynomial result = Product.buildResult(results);
        long endTime = System.currentTimeMillis();
        System.out.println("Result:" + result);
        System.out.println("Execution time: " + (endTime - startTime) + " ms");
    }

    private static void multiplySimpleWorker(int me) {
        System.out.printf("Worker %d started\n", me);

        Object[] objCoefficientsA = new Object[2];
        Object[] objCoefficientsB = new Object[2];
        int[] begin = new int[1];
        int[] end = new int[1];


        MPI.COMM_WORLD.Recv(objCoefficientsA, 0, 1, MPI.OBJECT, 0, 0);
        MPI.COMM_WORLD.Recv(objCoefficientsB, 0, 1, MPI.OBJECT, 0, 0);

        MPI.COMM_WORLD.Recv(begin, 0, 1, MPI.INT, 0, 0);
        MPI.COMM_WORLD.Recv(end, 0, 1, MPI.INT, 0, 0);

        Polynomial a = new Polynomial(createCoefficientList(objCoefficientsA, 0));
        Polynomial b = new Polynomial(createCoefficientList(objCoefficientsB, 0));

        Polynomial result = Product.simpleSequential(a, b, begin[0], end[0]);

        MPI.COMM_WORLD.Send(new Object[]{result.getCoefficients().toString().substring(1, result.getCoefficients().toString().length() - 1)}, 0, 1, MPI.OBJECT, 0, 0);
    }

    private static List<Integer> createCoefficientList(Object[] objCoefficientsB, int offset) {
        String stringCoefficientsB = (String) objCoefficientsB[offset];
        ArrayList<String> stringsListCoefficientsB = new ArrayList<String>(Arrays.asList(stringCoefficientsB.split(",")));
        List<Integer> coefficientsB = new ArrayList<Integer>();
        for(String fav:stringsListCoefficientsB){
            coefficientsB.add(Integer.parseInt(fav.trim()));
        }
        return coefficientsB;
    }

    private static void multiplyKaratsubaWorker(int me) {
        System.out.printf("Worker %d started\n", me);

        Object[] objCoefficientsA = new Object[2];
        Object[] objCoefficientsB = new Object[2];
        int[] begin = new int[1];
        int[] end = new int[1];

        MPI.COMM_WORLD.Recv(objCoefficientsA, 0, 1, MPI.OBJECT, 0, 0);
        MPI.COMM_WORLD.Recv(objCoefficientsB, 0, 1, MPI.OBJECT, 0, 0);

        MPI.COMM_WORLD.Recv(begin, 0, 1, MPI.INT, 0, 0);
        MPI.COMM_WORLD.Recv(end, 0, 1, MPI.INT, 0, 0);

        Polynomial a = new Polynomial(createCoefficientList(objCoefficientsA, 0));
        Polynomial b = new Polynomial(createCoefficientList(objCoefficientsB, 0));

        for (int i = 0; i < begin[0]; i++) {
            a.getCoefficients().set(i, 0);
        }
        for (int j = end[0]; j < a.getCoefficients().size(); j++) {
            a.getCoefficients().set(j, 0);

        }

        Polynomial result = Product.karatsubaSequential(a, b);

        MPI.COMM_WORLD.Send(new Object[]{result.getCoefficients().toString().substring(1, result.getCoefficients().toString().length() - 1)}, 0, 1, MPI.OBJECT, 0, 0);
    }
}
