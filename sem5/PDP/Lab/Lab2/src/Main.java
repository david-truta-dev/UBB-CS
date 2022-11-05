import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args)
            throws InterruptedException {
        final ProducerConsumer pc = new ProducerConsumer();

        List<Integer> vector1 = new ArrayList<>(Arrays.asList(1, 2, 3, 4, 1, 1, 9, 7, 4, 1));
        List<Integer> vector2 = new ArrayList<>(Arrays.asList(2, 7, 2, 1, 6, 9, 1, 1, 4, 1));

        Thread t1 = new Thread(() -> {
            try {
                pc.produce(vector1, vector2);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });
        Thread t2 = new Thread(() -> {
            try {
                pc.consume(vector1.size());
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        });

        if (vector1.size() == vector2.size()) {
            t1.start();
            t2.start();

            t1.join();
            t2.join();
        }
    }
}