import domain.SymTable;

public class Main {

    public static void main(String[] args) {
        SymTable<String> symTable = new SymTable<>();

        symTable.add("Marcel");
        symTable.add("Usu");

        System.out.println(symTable.getPos("Usu"));
        System.out.println(symTable.getPos("Marcel"));
        System.out.println(symTable.getPos("NuEste"));
    }
}