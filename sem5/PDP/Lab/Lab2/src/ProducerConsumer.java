import java.util.LinkedList;
import java.util.List;

public class ProducerConsumer {

    LinkedList<Integer> list = new LinkedList<>();
    int capacity = 5;

    public void produce(List<Integer> v1, List<Integer> v2) throws InterruptedException {
        for (int i = 0; i < v1.size(); i++) {
            synchronized (this) {
//                while (list.size() == capacity)
//                    wait();

                int product = v1.get(i) * v2.get(i);
                list.add(product);

                System.out.println("Producer: " + v1.get(i) + " * " + v2.get(i) + " = " + product);

                notify();

                Thread.sleep(100);
            }
        }
    }

    public void consume(int n) throws InterruptedException {
        int sum = 0;

        for (int i = 0; i < n; i++) {
            synchronized (this) {
                while (list.isEmpty())
                    wait();

                int val = list.removeFirst();
                sum += val;

                System.out.println("Consumer - current sum: " + sum);
                notify();

                Thread.sleep(100);
            }
        }
    }
}