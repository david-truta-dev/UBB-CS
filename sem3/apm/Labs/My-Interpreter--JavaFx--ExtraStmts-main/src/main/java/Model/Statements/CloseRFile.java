package Model.Statements;

import Exceptions.CloseRFileException;
import Exceptions.DictionaryException;
import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.StringType;
import Model.Types.Type;
import Model.Values.StringValue;
import java.io.BufferedReader;
import java.io.IOException;

public class CloseRFile implements IStmt{
    private final Exp e;

    public CloseRFile(Exp E){
        this.e = E;
    }

    @Override
    public IStmt deepCopy() {
        return new CloseRFile(e.deepCopy());
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        if (this.e.eval(state.getSymTable(), state.getHeap()) instanceof StringValue str){
            try{
                BufferedReader br = state.getFileTable().lookup(str);
                try {
                    br.close();
                    state.getFileTable().removeElement(str);
                    return null;
                } catch (IOException ex) {
                    throw new CloseRFileException("Error while closing the file!");
                }
            }catch (DictionaryException de){
                throw new CloseRFileException("There is no such file opened!");
            }
        }
        else throw new CloseRFileException("Incorrect argument type!");
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        if (e.typeCheck(typeEnv).equals(new StringType())) {
            return typeEnv;
        }else throw new CloseRFileException("The parameter must pe of type String!");
    }

    @Override
    public String toString(){
        return "closeRFile(" + this.e.toString() + ")";
    }
}
