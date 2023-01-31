import java.io.Serializable;

public class Wrapper implements Serializable {

    Graph graph;
    int start;
    int end;

    public Wrapper(Graph graph, int start, int end) {
        this.graph = graph;
        this.start = start;
        this.end = end;
    }
}
