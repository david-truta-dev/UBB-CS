package Model.Expressions;

import Exceptions.ArithExpException;
import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.Value;

import java.util.Objects;

public class ArithExp implements Exp {
    private final Exp e1;
    private final Exp e2;
    private final Character op;

    public ArithExp(Character op, Exp E1, Exp E2) {
        this.e1 = E1;
        this.e2 = E2;
        this.op = op;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTbl,  MyIDictionary<Integer, Value> heap) throws MyException {
        Value v1, v2;
        v1 = e1.eval(symTbl, heap);
        if (v1.getType().equals(new IntType())) {
            v2 = e2.eval(symTbl, heap);
            if (v2.getType().equals(new IntType())) {
                IntValue i1 = (IntValue) v1;
                IntValue i2 = (IntValue) v2;
                int n1, n2;
                n1 = i1.getValue();
                n2 = i2.getValue();
                if (Objects.equals(op, '+')) return new IntValue(n1 + n2);
                if (Objects.equals(op, '-')) return new IntValue(n1 - n2);
                if (Objects.equals(op, '*')) return new IntValue(n1 * n2);
                if (Objects.equals(op, '/'))
                    if (n2 == 0) throw new ArithExpException("division by zero");
                    else return new IntValue(n1 / n2);
            } else throw new ArithExpException("second operand is not an integer");
        } else throw new ArithExpException("first operand is not an integer");
        return null;
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typ1, typ2;
        typ1=e1.typeCheck(typeEnv);
        typ2=e2.typeCheck(typeEnv);
        if (typ1.equals(new IntType())) {
            if (typ2.equals(new IntType())) {
                return new IntType();
            } else throw new MyException("Second operand is not an integer!");
        }else throw new MyException("First operand is not an integer!");
    }

    @Override
    public String toString(){
        return e1.toString() + op + e2.toString();
    }

    @Override
    public Exp deepCopy() {
        return new ArithExp(this.op, this.e2.deepCopy(), this.e2.deepCopy());
    }
}
