package Model.Statements;

import Exceptions.DictionaryException;
import Exceptions.MyException;
import Exceptions.ReadFileException;
import Model.ADTs.MyIDictionary;
import Model.Expressions.Exp;
import Model.PrgState;
import Model.Types.IntType;
import Model.Types.StringType;
import Model.Types.Type;
import Model.Values.IntValue;
import Model.Values.StringValue;
import Model.Values.Value;


import java.io.BufferedReader;
import java.io.IOException;

public class ReadFile implements IStmt{
    private final Exp e;
    private final String varName;

    public ReadFile(Exp E, String vn){
        this.e = E;
        this.varName = vn;
    }

    @Override
    public IStmt deepCopy() {
        return new ReadFile(e.deepCopy(), varName);
    }

    @Override
    public PrgState execute(PrgState state) throws MyException {
        try{
            Value v = state.getSymTable().getElem(varName);
            if(v.getType() instanceof IntType){
                if (e.eval(state.getSymTable(), state.getHeap()) instanceof StringValue str){
                    try {
                        BufferedReader br = state.getFileTable().lookup(str);
                        String line = br.readLine();
                        int val = Integer.parseInt(line);
                        state.getSymTable().update(varName, new IntValue(val));
                        return null;
                    }catch (DictionaryException de){
                        throw new ReadFileException("There are no opened files with this name!");
                    } catch (IOException ioException) {
                        throw new ReadFileException("Error reading line!");
                    }
                }
                else throw new ReadFileException("First argument must be a StringValue!");
            }
            else throw new ReadFileException("Second argument isn't IntType!");
        }catch (DictionaryException dr) {
            throw new ReadFileException("Second argument is not declared!");
        }
    }

    @Override
    public MyIDictionary<String, Type> typeCheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        if(typeEnv.lookup(varName).equals( new IntType()))
            if (e.typeCheck(typeEnv).equals(new StringType()))
                return typeEnv;
            else throw new ReadFileException("The second parameter must pe of type String!");
        else throw new ReadFileException("The first parameter must pe of type Int!");
    }

    @Override
    public String toString(){
        return "readFile(" + this.e.toString() + ", "+ this.varName + ")";
    }
}
