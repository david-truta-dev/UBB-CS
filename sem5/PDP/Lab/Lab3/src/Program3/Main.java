package Program3;

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

        int elements = size * size / tasks;
        int extraElements = size * size % tasks;

        Long startTime = System.currentTimeMillis();

        for(int i = 0; i < tasks; i++){
            int startIndex = i * elements;
            int endIndex = (i + 1) * elements - 1;

            if (i == tasks-1) endIndex += extraElements;

            int finalEndIndex = endIndex;

            Thread t = new Thread(() -> MatrixHelper.computeMultiplicationResultElements(startIndex, finalEndIndex, firstMatrix, secondMatrix, resultMatrix));

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
