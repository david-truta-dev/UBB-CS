
import java.io.Serializable;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class Node implements Serializable {

    int label;
    int color;
    Set<Integer> neighbours = new HashSet<>();

    public Node(int label, int color) {
        this.label = label;
        this.color = color;
    }

    public Node(int label) {
        this.label = label;
        this.color = -1;
    }

    public int getLabel() {
        return label;
    }

    public void setLabel(int label) {
        this.label = label;
    }

    public int getColor() {
        return color;
    }

    public void setColor(int color) {
        this.color = color;
    }

    public void addNeighbour(int n){
        neighbours.add(n);
    }

    public Set<Integer> getNeighbours(){
        return neighbours;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Node node = (Node) o;
        return label == node.label;
    }

    @Override
    public int hashCode() {
        return Objects.hash(label);
    }
}
