package Program4;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        int size = 9;
        int tasks = 4;
        int threads = 4;

        List<List<Integer>> firstMatrix = MatrixHelper.generateMatrix(size);
        List<List<Integer>> secondMatrix = MatrixHelper.generateMatrix(size);

        List<List<Integer>> resultMatrix = MatrixHelper.generateEmptyMatrix(size);

        // Thread pool
        List<Runnable> taskList = new ArrayList<>();

        ExecutorService pool = Executors.newFixedThreadPool(threads);

        int elements = size * size / tasks;
        int extraElements = size * size % tasks;

        Long startTime = System.currentTimeMillis();

        for(int i = 0; i < tasks; i++){
            int startIndex = i * elements;
            int endIndex = (i + 1) * elements - 1;

            if (i == tasks-1) endIndex += extraElements;

            int finalEndIndex = endIndex;

            Runnable r = () -> MatrixHelper.computeMultiplicationResultElements(startIndex, finalEndIndex, firstMatrix, secondMatrix, resultMatrix);

            taskList.add(r);
        }

        for (Runnable task: taskList){
            pool.execute(task);
        }

        pool.shutdown();

        Long endTime = System.currentTimeMillis();

        Long runTime = (endTime - startTime);

        System.out.println(runTime);

//        System.out.println(firstMatrix.toString());
//        System.out.println(secondMatrix.toString());
//        System.out.println(resultMatrix.toString());
    }
}
