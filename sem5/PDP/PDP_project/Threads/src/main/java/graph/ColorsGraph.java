package graph;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

@Getter
@Setter
@ToString
public class ColorsGraph {
    private int colorsNo;
    private Map<Integer, String> codesToColors;

    public ColorsGraph(int colorsNo) {
        this.colorsNo = colorsNo;

        codesToColors = new HashMap<>();
        for (int code = 0; code < colorsNo; code++) {
            codesToColors.put(code, "");
        }
    }

    public void addCodeToColor(int code, String color) {
        codesToColors.put(code, color);
    }

    public Map<Integer, String> getIndexesToColors(List<Integer> codes) {
        Map<Integer, String> map = new HashMap<>();

        for (int index = 0; index < codes.size(); index++) {
            String color = codesToColors.get(codes.get(index));
            map.put(index, color);
        }

        return map;
    }
}
