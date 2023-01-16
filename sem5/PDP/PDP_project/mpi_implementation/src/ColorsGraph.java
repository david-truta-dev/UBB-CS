import java.util.HashMap;
import java.util.Map;


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

    public Map<Integer, String> getNodesToColors(int[] codes) {
        Map<Integer, String> map = new HashMap<>();

        for (int index = 0; index < codes.length; index++) {
            String color = codesToColors.get(codes[index]);
            map.put(index, color);
        }

        return map;
    }

    public int getColorsNo() {
        return colorsNo;
    }

    public void setColorsNo(int colorsNo) {
        this.colorsNo = colorsNo;
    }

    public Map<Integer, String> getCodesToColors() {
        return codesToColors;
    }

    public void setCodesToColors(Map<Integer, String> codesToColors) {
        this.codesToColors = codesToColors;
    }
}
