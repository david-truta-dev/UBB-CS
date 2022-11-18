package Program5;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {

        int size = 9;
        int tasks = 4;

        List<List<Integer>> firstMatrix = MatrixHelper.generateMatrix(size);
        List<List<Integer>> secondMatrix = MatrixHelper.generateMatrix(size);

        List<List<Integer>> resultMatrix = MatrixHelper.generateEmptyMatrix(size);

        // Individual thread start
        List<Thread> threads = new ArrayList<>();

        Long startTime = System.currentTimeMillis();

        for(int i = 0; i < tasks; i++){
            int startIndex = i;

            Thread t = new Thread(() -> MatrixHelper.computeMultiplicationResultElements(startIndex, tasks, firstMatrix, secondMatrix, resultMatrix));

            threads.add(t);
            t.start();
        }

        for(Thread thread: threads){
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        Long endTime = System.currentTimeMillis();

        Long runTime = (endTime - startTime);

        System.out.println(runTime);

        //System.out.println(firstMatrix.toString());
        //System.out.println(secondMatrix.toString());
        //System.out.println(resultMatrix.toString());
    }
}