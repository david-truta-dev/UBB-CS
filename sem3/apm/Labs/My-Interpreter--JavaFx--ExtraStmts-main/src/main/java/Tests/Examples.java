package Tests;

import Model.Expressions.*;
import Model.Statements.*;
import Model.Types.BoolType;
import Model.Types.IntType;
import Model.Types.RefType;
import Model.Types.StringType;
import Model.Values.BoolValue;
import Model.Values.IntValue;
import Model.Values.StringValue;
import Model.Values.Value;
import javafx.scene.control.cell.ComboBoxListCell;

public class Examples {
    public static IStmt exmpl1() {
        // int v; v=true; print(v); SHOULD RAISE AN ERROR
        return new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new AssignStmt("v",
                new ValueExp(new BoolValue(true))), new PrintStmt(new VarExp("v"))));
    }

    public static IStmt exmpl2() {
        // int a; int b; a=2+3*5; b=a+1; print(b)
        return new CompStmt(new VarDeclStmt("a", new IntType()), new CompStmt(new VarDeclStmt("b",
                new IntType()), new CompStmt(new AssignStmt("a", new ArithExp('+', new ValueExp(new IntValue(2)),
                new ArithExp('*', new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                new CompStmt(new AssignStmt("b", new ArithExp('+', new VarExp("a"),
                        new ValueExp(new IntValue(1)))), new PrintStmt(new VarExp("b"))))));
    }

    public static IStmt exmpl3() {
        // bool a; int v; a=true;  if (a): v=2; else: v=3; print(v)
        return new CompStmt(new VarDeclStmt("a", new BoolType()), new CompStmt(new VarDeclStmt("v", new IntType())
                , new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                new CompStmt(new IfStmt(new VarExp("a"), new AssignStmt("v", new ValueExp(new IntValue(2))),
                        new AssignStmt("v", new ValueExp(new IntValue(3)))), new PrintStmt(new VarExp("v"))))));
    }

    public static IStmt exmpl4() {
        // bool a; a=false; bool b; b=true; int c; print(c) if(a or b) c=1;  if (a and b): c=2; print(c)
        return new CompStmt(new VarDeclStmt("a", new BoolType()), new CompStmt(new AssignStmt("a",
                new ValueExp(new BoolValue(false))), new CompStmt(new VarDeclStmt("b", new BoolType()),
                new CompStmt(new AssignStmt("b", new ValueExp(new BoolValue(true))),
                        new CompStmt(new VarDeclStmt("c", new IntType()), new CompStmt(new PrintStmt(new VarExp("c"))
                                , new CompStmt(new IfStmt(new LogicExp("or", new VarExp("a"), new VarExp("b")),
                                new AssignStmt("c", new ValueExp(new IntValue(1))), new NopStmt()),
                                new CompStmt(new IfStmt(new LogicExp("and", new VarExp("a"), new VarExp("b")),
                                        new AssignStmt("c", new ValueExp(new IntValue(2))), new NopStmt()),
                                        new PrintStmt(new VarExp("c"))))))))));
    }

    public static IStmt exmpl5() {
        // string varf; varf="test.in"; openRFile(varf); int varc; readFile(varf,varc); print(varc);
        // readFile(varf,varc); print(varc); closeRFile(varf)
        return new CompStmt(new VarDeclStmt("varf", new StringType()), new CompStmt(new AssignStmt("varf",
                new ValueExp(new StringValue("test.in"))), new CompStmt(new OpenRFile(new VarExp("varf")),
                new CompStmt(new VarDeclStmt("varc", new IntType()), new CompStmt(new ReadFile(new VarExp("varf"),
                        "varc"), new CompStmt(new PrintStmt(new VarExp("varc")), new CompStmt(
                        new ReadFile(new VarExp("varf"), "varc"), new CompStmt(
                        new PrintStmt(new VarExp("varc")), new CloseRFile(new VarExp("varf"))))))))));
    }

    public static IStmt exmpl6() {
        // Ref int v; new (v,20); print(rH(v)); wH(v, 30); print(rH(v) + 5);
        return new CompStmt(new VarDeclStmt("v", new RefType(new IntType())), new CompStmt(new NewStmt("v",
                new ValueExp(new IntValue(20))),new CompStmt( new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                new CompStmt(new WriteHeapStmt("v", new ValueExp(new IntValue(30))), new PrintStmt(new ArithExp(
                        '+',new ReadHeapExp(new VarExp("v")),new ValueExp(new IntValue(5))))))));
    }

    public static IStmt exmpl7() {
        // int v; v = 4; while(v>0) { print(v); v=v-1; }; print(v)
        return new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new AssignStmt("v", new ValueExp(
                new IntValue(4))),new CompStmt(new WhileStmt(new RelExp(new VarExp("v"),
                new ValueExp(new IntValue(0)),">"), new CompStmt(new PrintStmt(new VarExp("v")),new AssignStmt(
                        "v", new ArithExp('-', new VarExp("v"),new ValueExp(new IntValue(1)))))),
                new CompStmt(new PrintStmt(new VarExp("v")),new NopStmt()))));
    }

    public static IStmt exmpl8() {
        // Ref int v; new(v,20); Ref Ref int a; new(a,v); new(v,30); print(rH(rH(a)))
        return new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),new CompStmt(new NewStmt("v",
                new ValueExp(new IntValue(20))),new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                new CompStmt(new NewStmt("a", new VarExp("v")),new CompStmt(new NewStmt("v", new ValueExp(
                        new IntValue(30))),new PrintStmt(new ReadHeapExp(new ReadHeapExp(new VarExp("a")))))))));
    }

    public static IStmt exmpl9() {
        // int v; Ref int a; v=10;new(a,22); fork(wH(a,30);v=32;print(v); print(rH(a)));
        // print(v); print(rH(a))
        return new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new VarDeclStmt(
                "a", new RefType(new IntType())), new CompStmt(new AssignStmt("v",new ValueExp(
                        new IntValue(10))), new CompStmt(new NewStmt("a",new ValueExp(new IntValue(22))),
                new CompStmt(new ForkStmt(new CompStmt(new WriteHeapStmt("a",new ValueExp(new IntValue(30))),
                        new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(32))), new CompStmt(
                                new PrintStmt(new VarExp("v")),new PrintStmt(new ReadHeapExp(
                                        new VarExp("a"))))))), new CompStmt(new PrintStmt(new VarExp("v")),
                        new PrintStmt(new ReadHeapExp(new VarExp("a")))))))));
    }

    public static IStmt exmpl10() {
        // int v; int x; int y; v=0;
        // repeat (fork(print(v);v=v-1);v=v+1) until (v==3);
        // x=1;nop;y=3;nop;
        // print(v*10)
        return new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new VarDeclStmt("x", new IntType()), new CompStmt(
                new VarDeclStmt("y", new IntType()), new CompStmt(new AssignStmt("v",new ValueExp(new IntValue(0))), new CompStmt(
                        new RepeatUntilStmt(
                                new CompStmt(
                                new ForkStmt(
                                new CompStmt(new PrintStmt(new VarExp("v")),
                                        new AssignStmt("v",new ArithExp('-',new VarExp("v"),new ValueExp(new IntValue(1)))))
                                ), new AssignStmt("v",new ArithExp('+',new VarExp("v"),new ValueExp(new IntValue(1))))),
                                new RelExp(new VarExp("v"),new ValueExp(new IntValue(3)), "==")
                        ),
                new CompStmt(new AssignStmt("x", new ValueExp(new IntValue(1))),new CompStmt(new NopStmt(),new CompStmt(new AssignStmt("y", new ValueExp(new IntValue(3))),
                        new CompStmt(new NopStmt(),new CompStmt(new PrintStmt(new ArithExp('*',new VarExp("v"), new ValueExp(new IntValue(10)))),
                                new NopStmt()))))))))));
    }

    public static IStmt exmpl11(){
        // int v;v=20;
        // (for(v=0;v<3;v=v+1) fork(print(v);v=v+1) );
        // print(v*10)


        return new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new ForStmt(new ValueExp(new IntValue(0))
                                ,new ValueExp(new IntValue(3))
                                ,new ArithExp('+', new VarExp("v"), new ValueExp(new IntValue(1)))
                                ,new ForkStmt(
                                        new CompStmt(
                                                new PrintStmt(new VarExp("v")),
                                                new AssignStmt("v",new ArithExp('+',new VarExp("v"), new ValueExp(new IntValue(1))))
                                        )) ),
                                new PrintStmt(new ArithExp('*',new VarExp("v"),new ValueExp(new IntValue(10)))))));
    }

    public static IStmt exmpl12(){
        //int v1;int v2; v1=2; v2=3;
        // if (v1) print(MUL(v1,v2))
        // else print (v1)
        return new CompStmt(new VarDeclStmt("v1", new IntType()),new CompStmt(new VarDeclStmt("v2", new IntType()),
                new CompStmt(new AssignStmt("v1", new ValueExp(new IntValue(2))),new CompStmt(new AssignStmt("v2", new ValueExp(new IntValue(3))),
                        new IfStmt(new RelExp(new VarExp("v1"), new ValueExp(new IntValue(0)),"!="),new PrintStmt(
                                new MulExp(new VarExp("v1"),new VarExp("v2"))), new PrintStmt(new VarExp("v1")))))));
    }

    public static IStmt exmpl13(){
        // int v; v=20; wait(10);print(v*10)
        return new CompStmt(new VarDeclStmt("v", new IntType()),new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(20))),
                new CompStmt(new WaitStmt(new ValueExp(new IntValue(10))),
                        new PrintStmt(new ArithExp('*',new VarExp("v"),new ValueExp(new IntValue(10)))))));
    }

    public static IStmt exmpl14(){
        //int v;
        //while(v<3) {fork(print(v);v=v+1); v=v+1;}
        //sleep(5); print(v*10);
        return new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(
                new WhileStmt(new RelExp(new VarExp("v"),new ValueExp(new IntValue(3)),"<"),
                        new CompStmt(new ForkStmt(new CompStmt(new PrintStmt(new VarExp("v")),
                                new AssignStmt("v",new ArithExp('+',new VarExp("v"), new ValueExp(new IntValue(1)))))),
                                new AssignStmt("v",new ArithExp('+',new VarExp("v"), new ValueExp(new IntValue(1)))))),
                new CompStmt(new SleepStmt(new ValueExp(new IntValue(5))),new PrintStmt(new ArithExp('*',new VarExp("v"),new ValueExp(new IntValue(10)))))));
    }

    public  static  IStmt exmpl15(){
        // int a; int b; int c;
        // a=1;b=2;c=5;
        // switch(a*10){
        // case (b*c) : { print(a); print(b) }
        // case (10) : { print(100); print(200) )
        // default : { print(300)); } }
        // print(300)
        return new CompStmt(new VarDeclStmt("a", new IntType()),
                new CompStmt(new VarDeclStmt("b", new IntType()),
                new CompStmt(new VarDeclStmt("c", new IntType()),
                new CompStmt(new AssignStmt("a", new ValueExp(new IntValue(1))),
                new CompStmt(new AssignStmt("b", new ValueExp(new IntValue(2))),
                new CompStmt(new AssignStmt("c", new ValueExp(new IntValue(5))),
                new CompStmt(new SwitchStmt(new ArithExp('*', new VarExp("a"), new ValueExp(new IntValue(10))),
                        new ArithExp('*', new VarExp("b"), new VarExp("c")),
                        new ValueExp(new IntValue(10)),
                        new CompStmt(new PrintStmt(new VarExp("a")),new PrintStmt(new VarExp("b"))),
                        new CompStmt(new PrintStmt(new ValueExp(new IntValue(100))),new PrintStmt(new ValueExp(new IntValue(200)))),
                        new PrintStmt(new ValueExp(new IntValue(300)))),
                new PrintStmt(new ValueExp(new IntValue(300))))))))));
    }

    public  static  IStmt exmpl16() {
        // Ref int a; Ref int b; int v;
        // new(a,0); new(b,0);
        // wh(a,1); wh(b,2);
        // v=(rh(a)<rh(b))?100:200;
        // print(v);
        // v= ((rh(b)-2)>rh(a))?100:200;
        // print(v);

        return new CompStmt(new VarDeclStmt("a", new RefType(new IntType()))
                ,new CompStmt(new VarDeclStmt("b", new RefType(new IntType()))
                ,new CompStmt(new VarDeclStmt("v", new IntType())
                ,new CompStmt(new NewStmt("a", new ValueExp(new IntValue(0)))
                ,new CompStmt(new NewStmt("b", new ValueExp(new IntValue(0)))
                ,new CompStmt(new WriteHeapStmt("a", new ValueExp(new IntValue(1)))
                ,new CompStmt(new WriteHeapStmt("b", new ValueExp(new IntValue(2)))
                ,new CompStmt(new CondAssignStmt("v", new RelExp(new ReadHeapExp(new VarExp("a")),
                                    new ReadHeapExp(new VarExp("b")),"<"),new ValueExp(new IntValue(100)),
                                            new ValueExp(new IntValue(200)))
                ,new CompStmt(new PrintStmt(new VarExp("v"))
                ,new CompStmt(new CondAssignStmt("v",new RelExp(new ArithExp('-', new ReadHeapExp(new VarExp("b")),new ValueExp(new IntValue(2))),
                                            new ReadHeapExp(new VarExp("a")),">"),
                                    new ValueExp(new IntValue(100)), new ValueExp(new IntValue(200)))
                ,new PrintStmt(new VarExp("v"))))))))))));
    }

}
