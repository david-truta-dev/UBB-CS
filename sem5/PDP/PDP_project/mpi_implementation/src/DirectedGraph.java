import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class DirectedGraph {
    private int nodesNo;
    private Map<Integer, Set<Integer>> vertices;

    public DirectedGraph(int nodesNo) {
        this.nodesNo = nodesNo;

        vertices = new HashMap<>();
        for (int node = 0; node < nodesNo; node++) {
            vertices.put(node, new HashSet<>());
        }
    }

    public boolean addVertex(int fromVertex, int toVertex) {
        return vertices.get(fromVertex).add(toVertex);
    }

    public boolean isVertex(int fromVertex, int toVertex) {
        return vertices.get(fromVertex).contains(toVertex);
    }

    public int getNodesNo() {
        return nodesNo;
    }

    public void setNodesNo(int nodesNo) {
        this.nodesNo = nodesNo;
    }

    public Map<Integer, Set<Integer>> getVertices() {
        return vertices;
    }

    public void setVertices(Map<Integer, Set<Integer>> vertices) {
        this.vertices = vertices;
    }
}
