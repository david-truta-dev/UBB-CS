import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class Graph {
    private List<Integer> nodes;
    private List<List<Integer>> edges;

    public Graph(int nodes) {
        this.nodes = new ArrayList<>();
        for(var i=0;i<nodes;++i)
            this.nodes.add(i);
        generateEdges();
    }

    public Graph(List<Integer> nodes, List<List<Integer>> edges){
        this.nodes = nodes;
        this.edges = edges;
    }

    public void addEdge(int n1, int n2){
        if(!edges.get(n1).contains(n2))
            edges.get(n1).add(n2);
    }

    public List<Integer> edgesFromNode(int node){
        return edges.get(node);
    }

    public void generateEdges(){
        edges = new ArrayList<>();
        for(var ignored : nodes)
            edges.add(new ArrayList<>());

        Random random = new Random();
        var size = Math.pow(nodes.size(),2);

        for (int i = 0; i < size / 2; i++){
            int nodeA = random.nextInt(nodes.size());
            int nodeB = random.nextInt(nodes.size());

            addEdge(nodeA, nodeB);
        }
    }

    public List<Integer> getNodes() {
        return nodes;
    }

    public List<List<Integer>> getEdges() {
        return edges;
    }

    public int size(){
        return nodes.size();
    }

    @Override
    public String toString() {
        return "Graph{" +
                "nodes=" + nodes +
                ", edges=" + edges +
                '}';
    }
}