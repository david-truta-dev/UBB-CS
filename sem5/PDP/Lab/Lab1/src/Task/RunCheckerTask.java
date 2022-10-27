package ubb.pdp.Task;

import ubb.pdp.Checker.Checker;
import ubb.pdp.Main;

import java.util.TimerTask;

public class RunCheckerTask extends TimerTask {
    @Override
    public void run() {
        Checker consistencyChecker = new Checker(Main.inputNodes);

        System.out.println("Running checker...");
        boolean result = consistencyChecker.run();
        System.out.println("Checker returned result " + result + ".");
    }
}
