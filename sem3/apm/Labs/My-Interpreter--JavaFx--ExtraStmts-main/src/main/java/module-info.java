module Main {
    requires javafx.controls;
    requires javafx.fxml;


    opens Main to javafx.fxml;
    opens View to javafx.fxml;
    exports View;
    exports Main;
}