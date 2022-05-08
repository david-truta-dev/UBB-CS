import Controller.Controller;
import Exceptions.MyException;
import Model.ADTs.Heap;
import Model.ADTs.MyDictionary;
import Model.ADTs.MyList;
import Model.ADTs.MyStack;
import Model.PrgState;
import Model.Statements.*;
import Repository.Repository;
import Repository.IRepository;
import Tests.Examples;
import View.Commands.ExitCommand;
import View.Commands.RunExample;
import View.TextMenu;

public class Interpreter {

    public static void main(String[] args) {

        TextMenu menu = new TextMenu();
        menu.addCommand(new ExitCommand("0", "exit"));

        IStmt ex1 = Examples.exmpl1();
        try {
            ex1.typeCheck(new MyDictionary<>());
            PrgState prg1 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex1);
            IRepository repo1 = new Repository(prg1, "log1.txt");
            Controller ctr1 = new Controller(repo1);
            menu.addCommand(new RunExample("1", ex1.toString(), ctr1));
        } catch (MyException e) {
            e.printStackTrace();
        }


        IStmt ex2 = Examples.exmpl2();
        try {
            ex2.typeCheck(new MyDictionary<>());
            PrgState prg2 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex2);
            IRepository repo2 = new Repository(prg2, "log2.txt");
            Controller ctr2 = new Controller(repo2);
            menu.addCommand(new RunExample("2", ex2.toString(), ctr2));
        } catch (MyException e) {
            e.printStackTrace();
        }


        IStmt ex3 = Examples.exmpl3();
        try {
            ex3.typeCheck(new MyDictionary<>());
            PrgState prg3 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex3);
            IRepository repo3 = new Repository(prg3, "log3.txt");
            Controller ctr3 = new Controller(repo3);
            menu.addCommand(new RunExample("3", ex3.toString(), ctr3));
        } catch (MyException e) {
            e.printStackTrace();
        }


        IStmt ex4 = Examples.exmpl4();
        try {
            ex4.typeCheck(new MyDictionary<>());
            PrgState prg4 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex4);
            IRepository repo4 = new Repository(prg4, "log4.txt");
            Controller ctr4 = new Controller(repo4);
            menu.addCommand(new RunExample("4", ex4.toString(), ctr4));

        } catch (MyException e) {
            e.printStackTrace();
        }


        IStmt ex5 = Examples.exmpl5();
        try {
            ex5.typeCheck(new MyDictionary<>());
            PrgState prg5 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex5);
            IRepository repo5 = new Repository(prg5, "log5.txt");
            Controller ctr5 = new Controller(repo5);
            menu.addCommand(new RunExample("5", ex5.toString(), ctr5));
        } catch (MyException e) {
            e.printStackTrace();
        }


        IStmt ex6 = Examples.exmpl6();
        try {
            ex6.typeCheck(new MyDictionary<>());
            PrgState prg6 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex6);
            IRepository repo6 = new Repository(prg6, "log6.txt");
            Controller ctr6 = new Controller(repo6);
            menu.addCommand(new RunExample("6", ex6.toString(), ctr6));
        } catch (MyException e) {
            e.printStackTrace();
        }


        IStmt ex7 = Examples.exmpl7();
        try {
            ex7.typeCheck(new MyDictionary<>());
            PrgState prg7 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex7);
            IRepository repo7 = new Repository(prg7, "log7.txt");
            Controller ctr7 = new Controller(repo7);
            menu.addCommand(new RunExample("7", ex7.toString(), ctr7));
        } catch (MyException e) {
            e.printStackTrace();
        }


        IStmt ex8 = Examples.exmpl8();
        try {
            ex8.typeCheck(new MyDictionary<>());
            PrgState prg8 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex8);
            IRepository repo8 = new Repository(prg8, "log8.txt");
            Controller ctr8 = new Controller(repo8);
            menu.addCommand(new RunExample("8", ex8.toString(), ctr8));
        } catch (MyException e) {
            e.printStackTrace();
        }


        IStmt ex9 = Examples.exmpl9();
        try {
            ex8.typeCheck(new MyDictionary<>());
            PrgState prg9 = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyDictionary<>(), new Heap<>(),
                    new MyList<>(), ex9);
            IRepository repo9 = new Repository(prg9, "log9.txt");
            Controller ctr9 = new Controller(repo9);
            menu.addCommand(new RunExample("9", ex9.toString(), ctr9));
        } catch (MyException e) {
            e.printStackTrace();
        }

        menu.show();
    }

}