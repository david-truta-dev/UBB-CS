package View.Commands;

import Controller.Controller;

public class RunExample extends Command{
    private final Controller controller;

    public RunExample(String key, String description,Controller ctr){
        super(key, description);
        this.controller = ctr;
    }

    @Override
    public void execute() {
        controller.allSteps();
    }

}
