import java.util.TimerTask;
import java.util.concurrent.ThreadLocalRandom;


public class ModifyInputNodesTask extends TimerTask {
    @Override
    public void run() {
        int index = ThreadLocalRandom.current().nextInt(0, Main.inputNodes.size());
        Node node = Main.inputNodes.get(index);
        int value = ThreadLocalRandom.current().nextInt(-10, 11);

        node.addValue(value);

        System.out.println("Modified primary node "+index+" with value "+value);
    }
}
