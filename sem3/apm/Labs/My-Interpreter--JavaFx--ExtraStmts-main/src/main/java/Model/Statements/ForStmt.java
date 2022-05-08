package Model.Statements;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.Expressions.RelExp;
import Model.Expressions.ValueExp;
import Model.Expressions.VarExp;
import Model.PrgState;
import Model.Types.BoolType;
import Model.Types.IntType;
import Model.Types.Type;
import Model.Values.Value;

public class ForStmt implements  IStmt{

    private final Exp exp1;
    private final Exp exp2;
    private final Exp exp3;
    private final IStmt stmt;


    public ForStmt(Exp e1, Exp e2, Exp e3, IStmt stmt){
        exp1 = e1;
        exp2 = e2;
        exp3 = e3;
        this.stmt = stmt;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        try {
            state.getSymTable().lookup("v");
        }catch (MyException ignored){
            new VarDeclStmt("v", new IntType()).execute(state);
        }
        state.getStk().push(new CompStmt(new AssignStmt("v", exp1),
                new WhileStmt(new RelExp(new VarExp("v"), exp2,"<"),
                        new CompStmt(stmt, new AssignStmt("v",exp3))
                ))
        );
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typExp1=exp1.typeCheck(typeEnv);
        Type typExp2=exp2.typeCheck(typeEnv);
        Type typExp3=exp3.typeCheck(typeEnv);
        if (typExp1.equals(new IntType()) && typExp2.equals(new IntType()) && typExp3.equals(new IntType())) {
            stmt.typeCheck(typeEnv.deepCopy());
            return typeEnv;
        }
        else throw new MyException("The expressions of FOR need to be of type int!");
    }

    @Override
    public IStmt deepCopy() {
        return new ForStmt(exp1.deepCopy(), exp2.deepCopy(), exp3.deepCopy(), stmt.deepCopy());
    }

    @Override
    public String toString() {
        return "For(v=" + exp1 + ";v<" + exp2 + ";v=" + exp3 + "){" + stmt +
                '}';
    }
}
