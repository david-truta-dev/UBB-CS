# Assignment 10

## Requirements
1. Add multiple *undo* and *redo* functionality for the `add`, `remove`, and `update` operations. Implement this functionality using inheritance and polymorphism. You will have **Undo** and **Redo** buttons on the GUI, as well as a key combination to undo and redo the operations (e.g. `Ctrl+Z`, `Ctrl+Y`).

2. Show the contents of the `adoption list` / `movie watch list` / `shopping basket` / `tutorial watch list` using a table view. You must use the [Qt View/Model](https://doc.qt.io/qt-5/modelview.html) components (`QTableView`). Create your own model – a class which inherits from [`QAbstractTableModel`](https://doc.qt.io/qt-5/qabstracttablemodel.html).

## Bonus Possibility [0.1p]
Add multiple *undo* and *redo* functionality for the `adoption list` / `movie watch list` / `shopping basket` / `tutorial watch list`. This will be tested through the application's GUI.

## Bonus Possibility [0.1p]
Use custom Qt delegates. In one of the columns of the Qt table view that shows the elements of the `adoption list` / **etc...**, display an image of the dog, trench coat or a play button that plays the movie trailer or the tutorial - depending on the problem statement. See the example images below.

![image](https://user-images.githubusercontent.com/25611695/119180503-0bfef700-ba79-11eb-86ae-3a42d41bb437.png)
![image](https://user-images.githubusercontent.com/25611695/119180582-2507a800-ba79-11eb-921c-22f64a05522b.png)
