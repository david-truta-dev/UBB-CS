package Model.Expressions;

import Exceptions.LogicExpException;
import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Types.BoolType;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.IntValue;
import Model.Values.Value;

import java.util.Objects;

public class RelExp implements Exp {
    private final Exp exp1;
    private final Exp exp2;
    private final String op;

    public RelExp(Exp e1, Exp e2, String op){
        this.exp1 = e1;
        this.exp2 = e2;
        this.op = op;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTbl, MyIDictionary<Integer, Value> heap) throws MyException {
        Value nr1 = this.exp1.eval(symTbl, heap);
        if(nr1.getType() instanceof IntType){
            IntValue Nr1 = (IntValue) nr1; // downcast
            Value nr2 = this.exp2.eval(symTbl, heap);
            if(nr2.getType() instanceof IntType){
                IntValue Nr2 = (IntValue) nr2; // downcast
                if(Objects.equals(this.op, "<"))
                    return new BoolValue(Nr1.getValue() < Nr2.getValue());
                else if (Objects.equals(this.op, "<="))
                    return new BoolValue(Nr1.getValue() <= Nr2.getValue());
                else if (Objects.equals(this.op, "=="))
                    return new BoolValue(Nr1.getValue() == Nr2.getValue());
                else if (Objects.equals(this.op, "!="))
                    return new BoolValue(Nr1.getValue() != Nr2.getValue());
                else if (Objects.equals(this.op, ">="))
                    return new BoolValue(Nr1.getValue() >= Nr2.getValue());
                else if (Objects.equals(this.op, ">"))
                    return new BoolValue(Nr1.getValue() > Nr2.getValue());
                else throw new LogicExpException("Operator not recognized !");
            }else throw new LogicExpException("E2 is not a IntType !");
        }else throw new LogicExpException("E1 is not a IntType !");
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typ1, typ2;
        typ1=exp1.typeCheck(typeEnv);
        typ2=exp2.typeCheck(typeEnv);
        if (typ1.equals(new IntType())) {
            if (typ2.equals(new IntType())) {
                return new BoolType();
            } else throw new MyException("Second operand is not an integer!");
        }else throw new MyException("First operand is not an integer!");
    }

    @Override
    public String toString(){
        return this.exp1.toString() +" "+ this.op +" "+ this.exp2.toString();
    }

    @Override
    public Exp deepCopy() {
        return new RelExp(exp1.deepCopy(), exp2.deepCopy(), op);
    }
}
