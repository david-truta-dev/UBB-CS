import java.io.Serializable;
import java.util.*;

public class Polynomial implements Serializable {
    private List<Integer> coefficients;

    public Polynomial() {
        this.coefficients = new ArrayList<>();
    }

    public Polynomial(int size) {
        this.coefficients = new ArrayList<>();
        for (int i = 0; i < size; i++) {
            coefficients.add(0);
        }
    }

    public Polynomial(List<Integer> coefficients) {
        this.coefficients = coefficients;
    }

    public void generateCoefficients() {
        Random random = new Random();
        for (int i = 0; i < this.coefficients.size(); i++) {
            this.coefficients.set(i, random.nextInt(10));
        }
    }

    public int getDegree() {
        return this.coefficients.size() - 1;
    }

    public int getSize() {
        return this.coefficients.size();
    }

    public List<Integer> getCoefficients() {
        return this.coefficients;
    }

    public void setCoefficients(List<Integer> coefficients) {
        this.coefficients = coefficients;
    }

    public static Polynomial add(Polynomial p1, Polynomial p2){
        int minDegree = Math.min(p1.getDegree(), p2.getDegree());
        int maxDegree = Math.max(p1.getDegree(), p2.getDegree());
        Polynomial result = new Polynomial(maxDegree + 1);

        for (int i = 0; i <= minDegree; i++) {
            int sum = p1.getCoefficients().get(i) + p2.getCoefficients().get(i);
            result.getCoefficients().set(i, sum);
        }

        Polynomial remaining;
        if(p1.getDegree() > p2.getDegree())
            remaining = p1;
        else
            remaining = p2;
        for (int i = minDegree + 1; i <= maxDegree; i++) {
            result.getCoefficients().set(i, remaining.getCoefficients().get(i));
        }

        return result;
    }

    public static Polynomial subtract(Polynomial p1, Polynomial p2){
        int minDegree = Math.min(p1.getDegree(), p2.getDegree());
        int maxDegree = Math.max(p1.getDegree(), p2.getDegree());
        Polynomial result = new Polynomial(maxDegree + 1);

        for (int i = 0; i <= minDegree; i++) {
            int dif = p1.getCoefficients().get(i) - p2.getCoefficients().get(i);
            result.getCoefficients().set(i, dif);
        }

        Polynomial remaining;
        if(p1.getDegree() > p2.getDegree())
            remaining = p1;
        else
            remaining = p2;
        for (int i = minDegree + 1; i <= maxDegree; i++) {
            result.getCoefficients().set(i, remaining.getCoefficients().get(i));
        }

        int i = result.getCoefficients().size() - 1;
        while (result.getCoefficients().get(i) == 0 && i > 0) {
            result.getCoefficients().remove(i);
            i--;
        }

        return result;
    }

    public static Polynomial addZeros(Polynomial p, int offset) {
        List<Integer> coefficients = new ArrayList<>();
        for(int i = 0; i < offset; i++){
            coefficients.add(0);
        }

        coefficients.addAll(p.getCoefficients());

        return new Polynomial(coefficients);
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = this.coefficients.size() - 1; i >= 0; i--) {
            stringBuilder.append(this.coefficients.get(i)).append("x^").append(i).append(" + ");
        }
        stringBuilder.setLength(stringBuilder.length() - 3);
        return stringBuilder.toString();
    }
}