public class PolynomialTask implements Runnable {
    private int start;
    private int end;
    private Polynomial p1, p2, result;

    public PolynomialTask(int start, int end, Polynomial p1, Polynomial p2, Polynomial result) {
        this.start = start;
        this.end = end;
        this.p1 = p1;
        this.p2 = p2;
        this.result = result;
    }

    @Override
    public void run() {
        for (int index = start; index < end; index++) {
            if (index > result.getLength()) {
                return;
            }

            for (int j = 0; j <= index; j++) {
                if (j < p1.getLength() && (index - j) < p2.getLength()) {
                    int value = p1.getCoefficients().get(j) * p2.getCoefficients().get(index - j);
                    result.getCoefficients().set(index, result.getCoefficients().get(index) + value);
                }
            }
        }
    }
}
