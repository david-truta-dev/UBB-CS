package Repository;

import Model.PrgState;
import java.util.List;

public interface IRepository {
    void logPrgStateExec(PrgState ps);
    List<PrgState> getPrgList();
    void setPrgList(List<PrgState> l);
}
