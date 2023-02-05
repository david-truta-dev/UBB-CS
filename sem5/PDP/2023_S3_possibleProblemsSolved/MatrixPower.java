import java.util.concurrent.Callable;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

// Square matrix to the power of n

public class MatrixPower implements Callable<int[][]> {
    private final int[][] matrix;
    private final int n;

    public MatrixPower(int[][] matrix, int n) {
        this.matrix = matrix;
        this.n = n;
    }

    @Override
    public int[][] call() throws Exception {
        if (n == 0) {
            return createIdentityMatrix(matrix.length);
        } else if (n == 1) {
            return matrix;
        } else if (n % 2 == 0) {
            MatrixPower task = new MatrixPower(matrix, n / 2);
            Future<int[][]> future = Executors.newSingleThreadExecutor().submit(task);
            int[][] res = future.get();
            return multiplyMatrices(res, res);
        } else {
            MatrixPower task = new MatrixPower(matrix, n - 1);
            Future<int[][]> future = Executors.newSingleThreadExecutor().submit(task);
            int[][] res = future.get();
            return multiplyMatrices(matrix, res);
        }
    }

    private int[][] createIdentityMatrix(int size) {
        int[][] identity = new int[size][size];
        for (int i = 0; i < size; i++) identity[i][i] = 1;
        return identity;
    }

    private int[][] multiplyMatrices(int[][] A, int[][] B) {
        int size = A.length;
        int[][] res = new int[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                for (int k = 0; k < size; k++) {
                    res[i][j] += A[i][k] * B[k][j];
                }
            }
        }
        return res;
    }

//    public static void main(String[] args) throws Exception {
//        int[][] matrix = {{1, 2}, {3, 4}};
//        int n = 5;
//        MatrixPower task = new MatrixPower(matrix, n);
//        Future<int[][]> future = Executors.newSingleThreadExecutor().submit(task);
//        int[][] res = future.get();
//        for (int[] row : res) {
//            for (int val : row) {
//                System.out.print(val + " ");
//            }
//            System.out.println();
//        }
//    }
}