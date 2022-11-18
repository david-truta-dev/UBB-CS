package Program3;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MatrixHelper {
    public static List<List<Integer>> generateMatrix(int size){
        List<List<Integer>> matrix = new ArrayList<>();

        for (int i = 0; i < size; i++) {
            List<Integer> row = new ArrayList<>();
            for (int j = 0; j < size; j++){
                int val = 1;
                row.add(val);
            }
            matrix.add(row);
        }

        return matrix;
    }

    public static List<List<Integer>> generateEmptyMatrix(int size){
        List<List<Integer>> matrix = new ArrayList<>();

        for (int i = 0; i < size; i++) {
            List<Integer> row = new ArrayList<>();
            for (int j = 0; j < size; j++){
                int val = 0;
                row.add(val);
            }
            matrix.add(row);
        }

        return matrix;
    }

    private static int getMultiplicationResultElement (int row, int column, List<List<Integer>> firstMatrix, List<List<Integer>> secondMatrix) {
        int size = firstMatrix.size();
        int result = 0;

        for(int index = 0; index < size; index++) {
            result += firstMatrix.get(row).get(index) * secondMatrix.get(index).get(column);
        }

        return result;
    }

    public static void computeMultiplicationResultElements (int startIndex, int endIndex, List<List<Integer>> firstMatrix, List<List<Integer>> secondMatrix, List<List<Integer>> resultMatrix){
        int size = resultMatrix.size();

        for (int i = startIndex; i <= endIndex; i++) {
            int row = i % size;
            int column = i / size;

            int tempResult = getMultiplicationResultElement(row, column, firstMatrix, secondMatrix);
            resultMatrix.get(row).set(column, tempResult);
        }
        System.out.println(resultMatrix);

    }
}
