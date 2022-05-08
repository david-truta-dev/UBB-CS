package View;

import Controller.Controller;
import Exceptions.MyException;
import Model.ADTs.Heap;
import Model.ADTs.MyDictionary;
import Model.ADTs.MyList;
import Model.ADTs.MyStack;
import Model.PrgState;
import Model.Statements.IStmt;
import Repository.IRepository;
import Repository.Repository;
import Tests.Examples;
import javafx.animation.PauseTransition;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.layout.Pane;
import javafx.scene.text.Text;
import javafx.util.Duration;

import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;


public class SelectController implements Initializable{
    private ExecuteController executeController;
    @FXML
    private Scene scene;
    @FXML
    private Pane executePrgPane;
    @FXML
    private ListView<IStmt> programs;
    @FXML
    private Text typerchecker;

    @FXML
    public void initialize(URL url, ResourceBundle resourceBundle){
        programs.setItems(FXCollections.observableArrayList(getPrgStmt()));
    }

    @FXML
    void execute() {
        int index = programs.getSelectionModel().getSelectedIndex();

        if(index < 0)
            return;

        try {
            programs.getItems().get(index).typeCheck(new MyDictionary<>());
            PrgState prg = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), programs.getItems().get(index));
            IRepository repo = new Repository(prg, "log" + (index+1) + ".txt");
            Controller prgController = new Controller(repo);
            executeController.setPrgController(prgController);
            typerchecker.setText("");
            scene.setRoot(executePrgPane);
            executeController.setup();
        } catch (MyException e) {
            typerchecker.setText(e.getMessage());
        }

    }

    public void setScene(Scene scene) {
        this.scene = scene;
    }

    public void setExecutePrgPane(Pane execPane) {
        executePrgPane = execPane;
    }

    public void setExecuteController(ExecuteController ctrl) {
        this.executeController = ctrl;
        executeController.setScene(scene);
    }

    private List<IStmt> getPrgStmt() {
        IStmt ex1 = Examples.exmpl1();
        IStmt ex2 = Examples.exmpl2();
        IStmt ex3 = Examples.exmpl3();
        IStmt ex4 = Examples.exmpl4();
        IStmt ex5 = Examples.exmpl5();
        IStmt ex6 = Examples.exmpl6();
        IStmt ex7 = Examples.exmpl7();
        IStmt ex8 = Examples.exmpl8();
        IStmt ex9 = Examples.exmpl9();
        IStmt ex10 = Examples.exmpl10();
        IStmt ex11 = Examples.exmpl11();
        IStmt ex12 = Examples.exmpl12();
        IStmt ex13 = Examples.exmpl13();
        IStmt ex14 = Examples.exmpl14();
        IStmt ex15 = Examples.exmpl15();
        IStmt ex16 = Examples.exmpl16();
        return new ArrayList<>(Arrays.asList(ex1, ex2, ex3,ex4, ex5, ex6, ex7, ex8, ex9, ex10, ex11, ex12, ex13, ex14, ex15, ex16));
    }

}
