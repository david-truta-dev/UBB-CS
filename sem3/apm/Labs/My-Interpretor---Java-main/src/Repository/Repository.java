package Repository;

import Model.PrgState;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class Repository implements IRepository{
    private ArrayList<PrgState> prgStates;
    String logFilePath ;

    public Repository(PrgState prg, String file){
        this.prgStates = new ArrayList<>();
        this.logFilePath = file;
        //Clear the file if exists:
        try {
            PrintWriter tmp = new PrintWriter(file);
            tmp.write("");
            tmp.close();
        } catch (FileNotFoundException ignored) {}
        this.prgStates.add(prg);
    }

    @Override
    public List<PrgState> getPrgList() {
        return this.prgStates;
    }

    @Override
    public void setPrgList(List<PrgState> l) {
         this.prgStates = (ArrayList<PrgState>) l;
    }

    @Override
    public void logPrgStateExec(PrgState ps) {
        try {
            PrintWriter logfile = new PrintWriter(new BufferedWriter(new FileWriter(this.logFilePath, true)));
            logfile.println(ps.toString());
            logfile.println("-----------------------------------------------------------------------------------");
            logfile.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
