package Model.Statements;

import Exceptions.DictionaryException;
import Exceptions.MyException;
import Exceptions.OpenRFileException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.StringType;
import Model.Types.Type;
import Model.Values.StringValue;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;

public class OpenRFile implements IStmt{
    private final Exp e;

    public OpenRFile(Exp E){
        this.e = E;
    }

    @Override
    public IStmt deepCopy() {
        return new OpenRFile(this.e.deepCopy());
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        if (this.e.eval(state.getSymTable(), state.getHeap()) instanceof StringValue str){
            try{
                state.getFileTable().lookup(str);
                throw new OpenRFileException("The file is already opened!");
            }catch (DictionaryException de){
                try {
                    BufferedReader br = new BufferedReader(new FileReader( str.getValue()));
                    state.getFileTable().addElement(str, br);
                    return null;
                } catch (FileNotFoundException ex) {
                    throw new OpenRFileException("File does not exist/cannot be opened!");
                }
            }
        }
        else throw new OpenRFileException("Incorrect argument type!");
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        if (e.typeCheck(typeEnv).equals(new StringType())) {
            return typeEnv;
        }else throw new OpenRFileException("The parameter must pe of type String!");
    }

    @Override
    public String toString(){
        return "openRFile(" + this.e.toString() + ")";
    }
}
