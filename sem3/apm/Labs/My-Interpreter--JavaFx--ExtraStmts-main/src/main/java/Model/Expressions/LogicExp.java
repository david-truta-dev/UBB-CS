package Model.Expressions;

import Exceptions.LogicExpException;
import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Types.BoolType;
import Model.Types.Type;
import Model.Values.BoolValue;
import Model.Values.Value;

import java.util.Objects;

public class LogicExp implements Exp{
    private final Exp e1;
    private final Exp e2;
    private final String op;

    public LogicExp(String o, Exp E1, Exp E2){
        op=o;
        e1=E1;
        e2=E2;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTbl,  MyIDictionary<Integer, Value> heap) throws MyException {
        Value nr1 = this.e1.eval(symTbl, heap);
        if(nr1.getType() instanceof BoolType){
            BoolValue Nr1 = (BoolValue) nr1; // downcast
            Value nr2 = this.e2.eval(symTbl, heap);
            if(nr2.getType() instanceof BoolType){
                BoolValue Nr2 = (BoolValue) nr2; // downcast
                if(Objects.equals(this.op, "and"))
                    return new BoolValue(Nr1.getValue() && Nr2.getValue());
                else if (Objects.equals(this.op, "or"))
                    return new BoolValue(Nr1.getValue() || Nr2.getValue());
                else throw new LogicExpException("Operator not recognized !");
            }else throw new LogicExpException("E2 is not a BoolType !");
        }else throw new LogicExpException("E1 is not a BoolType !");
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typ1, typ2;
        typ1=e1.typeCheck(typeEnv);
        typ2=e2.typeCheck(typeEnv);
        if (typ1.equals(new BoolType())) {
            if (typ2.equals(new BoolType())) {
                return new BoolType();
            } else throw new MyException("Second operand is not an integer!");
        }else throw new MyException("First operand is not an integer!");
    }

    @Override
    public String toString(){
        return this.e1.toString() +" "+ this.op +" "+ this.e2.toString();
    }

    @Override
    public Exp deepCopy() {
        return new LogicExp(this.op, this.e1.deepCopy(), this.e2.deepCopy());
    }
}
