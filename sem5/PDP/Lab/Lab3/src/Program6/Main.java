package Program6;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Main {
    public static void main(String[] args) {
        int size = 1000;
        int tasks = 8;
        int threads = 8;

        List<List<Integer>> firstMatrix = MatrixHelper.generateMatrix(size);
        List<List<Integer>> secondMatrix = MatrixHelper.generateMatrix(size);

        List<List<Integer>> resultMatrix = MatrixHelper.generateEmptyMatrix(size);

        // Thread pool
        List<Runnable> taskList = new ArrayList<>();

        ExecutorService pool = Executors.newFixedThreadPool(threads);

        Long startTime = System.currentTimeMillis();

        for(int i = 0; i < tasks; i++){

            int finalI = i;
            Runnable r = () -> MatrixHelper.computeMultiplicationResultElements(finalI, tasks, firstMatrix, secondMatrix, resultMatrix);

            taskList.add(r);
        }


        for (Runnable task: taskList){
            pool.execute(task);
        }

        pool.shutdown();

        Long endTime = System.currentTimeMillis();

        Long runTime = (endTime - startTime);

        System.out.println(runTime);

        for (var elem: resultMatrix) {
            for (var elem2: elem) {
                if (elem2.equals(1000)) {
                    System.out.println("Error");
                }
            }
        }
//        System.out.println(firstMatrix.toString());
//        System.out.println(secondMatrix.toString());
//        System.out.println(resultMatrix.toString());
    }

}
