import java.io.*;
import java.util.*;

public class Graph implements Serializable {

    List<Node> nodes = new ArrayList<>();

    int BOUND;
    public Graph(int nrNodes, int bound) {
        BOUND = bound;
        for(int i = 0; i < nrNodes; i++){
            Node node = new Node(i);
            nodes.add(node);
        }
        generateEdges(BOUND);
    }

    public void generateEdges(int maxEdgesPerNode){
        Random random = new Random();
        for(int i = 0; i < nodes.size(); i++){
            int nrEdgesToBeAdded = random.nextInt(maxEdgesPerNode);
            for(int j = 0; j < nrEdgesToBeAdded; j++){
                int m = random.nextInt(nodes.size());
                if(m != i){
                    addEdge(i, m);
                    addEdge(m, i);
                }
            }
        }
    }

    public void addEdge(int n, int m){
        nodes.get(n).addNeighbour(m);
    }

    public Graph(String fileName){
        try {
            File file = new File(fileName);
            FileReader fr = new FileReader(file);
            BufferedReader br = new BufferedReader(fr);

            String line = br.readLine();
            int nrNodes = Integer.parseInt(line);

            for(int i = 0; i < nrNodes; i++){
                Node node = new Node(i);
                nodes.add(node);
            }

            while((line = br.readLine()) != null)
            {
                String[] edge = line.split(" ");
                if(edge.length > 0){
                    int n = Integer.parseInt(edge[0]);
                    int m = Integer.parseInt(edge[1]);
                    if (n!=m){
                        addEdge(n, m);
                        addEdge(m, n);
                    }
                }
            }
            fr.close();
        }
        catch(IOException e){
            e.printStackTrace();
        }
    }

    public Node getNode(int n){
        return nodes.get(n);
    }

    public int getNrNodes(){
        return nodes.size();
    }

    @Override
    public String toString() {
        StringBuilder s = new StringBuilder();
        for(Node n: nodes){
            s.append("Node ").append(n.getLabel()).append(" - Color ").append(n.getColor()).append("\n");
        }
        return s.toString();
//        StringBuilder s = new StringBuilder();
//        var colorsMap = getGroupedColors();
//        for(Integer color: colorsMap.keySet()){
//            s.append(color).append(" - ").append(colorsMap.get(color)).append("\n");
//        }
//        return s.toString();
    }

    public Map<Integer, Set<Integer>> getGroupedColors(){
        Map<Integer, Set<Integer>> colorsMap = new HashMap<>();
        for(Node node: nodes){
            if(! colorsMap.containsKey(node.getColor())){
                colorsMap.put(node.getColor(), new HashSet<>());
            }
            colorsMap.get(node.getColor()).add(node.getLabel());
        }

        return colorsMap;
    }

    public boolean checkColoring(){
        for(Node node: nodes){
            for(Integer neighbour: node.getNeighbours()){
                if(node.getColor() == nodes.get(neighbour).getColor()){
                    return false;
                }
            }
        }
        return true;
    }
}
