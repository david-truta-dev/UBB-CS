package graph;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

@Getter
@Setter
@ToString
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

    public boolean isEdge(int fromVertex, int toVertex) {
        return vertices.get(fromVertex).contains(toVertex);
    }
}
