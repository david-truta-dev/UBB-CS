package Model.Expressions;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Types.BoolType;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.Value;

public class MulExp implements Exp{

    private final Exp e1;
    private final Exp e2;

    public MulExp(Exp exp1, Exp exp2){
        e1 = exp1;
        e2 = exp2;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> symTbl, MyIDictionary<Integer, Value> heap) throws MyException {
        Value v1 = this.e1.eval(symTbl, heap);
        Value v2 = this.e2.eval(symTbl, heap);
        if(v1.getType() instanceof IntType && v2.getType() instanceof IntType){
            return new ArithExp('-',new ArithExp('*',e1,e2),new ArithExp('+',e1,e2)).eval(symTbl,heap);
        }else throw new MyException("expressions must be of type int!");
    }

    @Override
    public Type typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        return null;
    }

    @Override
    public Exp deepCopy() {
        return new MulExp(e1.deepCopy(), e2.deepCopy());
    }

    @Override
    public String toString() {
        return "MUL(" + e1.toString() + ", " + e2.toString() + ')';
    }
}
