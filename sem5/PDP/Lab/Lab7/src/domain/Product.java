package domain;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Product {
    public static Polynomial simpleSequential(Polynomial a, Polynomial b, int begin, int end) {
        Polynomial result = buildEmptyPolynomial(a.getOrder() * 2 + 1);

        for (int i = begin; i < end; i++) {
            for (int j = 0; j < b.getSize(); j++) {
                result.getCoefficients().set(i + j, result.getCoefficients().get(i + j) + a.getCoefficients().get(i) * b.getCoefficients().get(j));
            }
        }
        return result;
    }

    public static Polynomial karatsubaSequential(Polynomial a, Polynomial b) {
        if (a.getOrder() < 2 || b.getOrder() < 2) {
            return simpleSequential(a, b);
        }

        int len = Math.max(a.getOrder(), b.getOrder()) / 2;
        Polynomial lowA = new Polynomial(a.getCoefficients().subList(0, len));
        Polynomial highA = new Polynomial(a.getCoefficients().subList(len, a.getSize()));
        Polynomial lowB = new Polynomial(b.getCoefficients().subList(0, len));
        Polynomial highB = new Polynomial(b.getCoefficients().subList(len, b.getSize()));

        Polynomial z1 = karatsubaSequential(lowA, lowB);
        Polynomial z2 = karatsubaSequential(add(lowA, highA), add(lowB, highB));
        Polynomial z3 = karatsubaSequential(highA, highB);

        //calculate the final result
        Polynomial r1 = addZeros(z3, 2 * len);
        Polynomial r2 = addZeros(subtract(subtract(z2, z3), z1), len);
        return add(add(r1, r2), z1);
    }

    private static Polynomial addZeros(Polynomial a, int lastPos) {
        List<Integer> coefficients = IntStream.range(0, lastPos).mapToObj(i -> 0).collect(Collectors.toList());
        coefficients.addAll(a.getCoefficients());
        return new Polynomial(coefficients);
    }

    private static Polynomial add(Polynomial a, Polynomial b) {
        int maxOrder = Math.max(a.getOrder(), b.getOrder());
        int minOrder = Math.min(a.getOrder(), b.getOrder());
        List<Integer> coefficients = new ArrayList<>(maxOrder + 1);

        for (int i = 0; i <= minOrder; i++) {
            coefficients.add(a.getCoefficients().get(i) + b.getCoefficients().get(i));
        }

        addRemainingCoefficients(a, b, coefficients);

        return new Polynomial(coefficients);
    }

    private static void addRemainingCoefficients(Polynomial a, Polynomial b, List<Integer> coefficients) {
        int maxOrder = Math.max(a.getOrder(), b.getOrder());
        int minOrder = Math.min(a.getOrder(), b.getOrder());

        if (minOrder == maxOrder)
            return;

        if (maxOrder == a.getOrder()) {
            for (int i = minOrder + 1; i <= maxOrder; i++) {
                coefficients.add(a.getCoefficients().get(i));
            }
        } else {
            for (int i = minOrder + 1; i <= maxOrder; i++) {
                coefficients.add(b.getCoefficients().get(i));
            }
        }
    }

    public static Polynomial subtract(Polynomial a, Polynomial b) {
        int minDegree = Math.min(a.getOrder(), b.getOrder());
        int maxDegree = Math.max(a.getOrder(), b.getOrder());
        List<Integer> coefficients = new ArrayList<>(maxDegree + 1);

        for (int i = 0; i <= minDegree; i++) {
            coefficients.add(a.getCoefficients().get(i) - b.getCoefficients().get(i));
        }

        addRemainingCoefficients(a, b, coefficients);

        int i = coefficients.size() - 1;
        while (coefficients.get(i) == 0 && i > 0) {
            coefficients.remove(i);
            i--;
        }

        return new Polynomial(coefficients);
    }

    public static Polynomial buildResult(ArrayList<Polynomial> results) {
        int order = results.get(0).getOrder();
        Polynomial result = buildEmptyPolynomial(order + 1);
        for (int i = 0; i < result.getCoefficients().size(); i++) {
            for (Polynomial o : results) {
                result.getCoefficients().set(i, result.getCoefficients().get(i) + o.getCoefficients().get(i));
            }
        }
        return result;
    }

    private static Polynomial buildEmptyPolynomial(int order) {
        List<Integer> zeros = IntStream.range(0, order).mapToObj(i -> 0).collect(Collectors.toList());
        return new Polynomial(zeros);
    }

    public static Polynomial simpleSequential(Polynomial a, Polynomial b) {
        int sizeOfResultCoefficientList = a.getOrder() + b.getOrder() + 1;
        List<Integer> coefficients = new ArrayList<>();
        for (int i = 0; i < sizeOfResultCoefficientList; i++) {
            coefficients.add(0);
        }
        for (int i = 0; i < a.getSize(); i++) {
            for (int j = 0; j < b.getSize(); j++) {
                int index = i + j;
                int value = a.getCoefficients().get(i) * b.getCoefficients().get(j);
                coefficients.set(index, coefficients.get(index) + value);
            }
        }
        return new Polynomial(coefficients);
    }
}