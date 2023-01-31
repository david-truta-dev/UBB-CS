import mpi.MPI;


import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public class Main {

    public static void main(String[] args) {
        MPI.Init(args);

        Graph graph = new Graph("g2.txt");
//        graph = new Graph(500, 100);

        int me = MPI.COMM_WORLD.Rank();

        boolean repeat = true;

        if(me==0){
            long startTime = System.nanoTime();

            Set<Integer> conflicting = IntStream.rangeClosed(0, graph.getNrNodes()).boxed().collect(Collectors.toSet());

            while (!conflicting.isEmpty()){
                conflicting = mainProcess(graph);
                sendToRepeat(!conflicting.isEmpty());
            }

            System.out.println(graph);
            System.out.println(graph.checkColoring());

            long endTime = System.nanoTime();

            long duration = (endTime - startTime)/1000000;
            System.out.printf("Execution took: %d ms", duration);
        }
        else{
            while (repeat){
                colorProcess();
                repeat = receiveToRepeat();
            }

        }

        MPI.Finalize();
    }

    public static Set<Integer> mainProcess(Graph graph){
        int size = MPI.COMM_WORLD.Size();

        //System.out.println(graph);
        // send graf + interval pt fiecare proces
        sendGraphToAllProcesses(graph);

        // de primit inapoi wrapper cu graful modificat:
        for (int i = 1; i < size; i++) {
            Wrapper[] buffer = new Wrapper[1];
            MPI.COMM_WORLD.Recv(buffer, 0, 1, MPI.OBJECT, MPI.ANY_SOURCE, MPI.ANY_TAG);
            modifyGraph(graph, buffer[0]);
        }

        //System.out.println(graph);
        // de trimis la toate procesele graful nou, ele vor verifica pe bucatele conflictele:
        sendGraphToAllProcesses(graph);

        // de primit conflictele

        Set<Integer> newConflicting = new HashSet<>();
        for (int i = 1; i < size; i++) {
            //System.out.println("Main 0 " + MPI.COMM_WORLD.Rank() + " received - new conflicting");
            Object[] buffer = new Object[1];
            MPI.COMM_WORLD.Recv(buffer, 0, 1, MPI.OBJECT, MPI.ANY_SOURCE, MPI.ANY_TAG);

            Set<Integer> response = (Set<Integer>) buffer[0];
            //System.out.println(response);
            newConflicting.addAll(response);
        }
        //System.out.println(newConflicting);

        //System.out.println(graph);
        return newConflicting;
    }

    public static void sendGraphToAllProcesses(Graph graph){
        int size = MPI.COMM_WORLD.Size();
        int nodesPerProcess = graph.getNrNodes() / (size-1);
        int remaining = graph.getNrNodes() % (size-1);

        int endOfLastP = 0;
        int start;
        for (int i = 0; i < size - 1; i++) {
            start = endOfLastP;
            int end;
            if (remaining > 0) {
                end = start + nodesPerProcess + 1;
                remaining--;
            } else {
                end = start + nodesPerProcess;
            }
            endOfLastP = end;

            Wrapper[] message = new Wrapper[1];
            Wrapper w = new Wrapper(graph, start, end);
            message[0] = w;
            MPI.COMM_WORLD.Send(message, 0, 1, MPI.OBJECT, i+1, 0);
        }
    }

    public static void colorProcess(){

        // 1: coloring
        Wrapper[] buffer = new Wrapper[1];

        //System.out.println("Slave " + MPI.COMM_WORLD.Rank() + " received first - graph+positions");
        MPI.COMM_WORLD.Recv(buffer, 0, 1, MPI.OBJECT, 0, MPI.ANY_TAG);

        Wrapper w = buffer[0];

        //System.out.println(MPI.COMM_WORLD.Rank() + " " + w.start + " - " + w.end);
        boolean toChange = false;
        for(int i = w.start; i < w.end; i++){
            Set<Integer> forbiddenColors = new HashSet<>();

            forbiddenColors.add(-1);
            Node currentNode = w.graph.getNode(i);
            for(int neighbour: currentNode.getNeighbours()){
                forbiddenColors.add(w.graph.getNode(neighbour).getColor());
                if(neighbour > i && currentNode.getColor() == w.graph.getNode(neighbour).getColor()){
                    toChange = true;
                }
            }

            int leastAvailableColor = 0;
            while(forbiddenColors.contains(leastAvailableColor)){
                leastAvailableColor++;
            }

            if(currentNode.getColor() == -1 || toChange)
                currentNode.setColor(leastAvailableColor);
        }

        Wrapper[] response = new Wrapper[1];
        response[0] = w;
        MPI.COMM_WORLD.Send(response, 0, 1, MPI.OBJECT, 0, 0);

        // 2: conflict detection

        Set<Integer> toBeRecolored = conflictDetection();
        Object[] r = new Object[1];
        r[0] = toBeRecolored;
        MPI.COMM_WORLD.Send(r, 0, 1, MPI.OBJECT, 0, 0);
    }

    public static Set<Integer> conflictDetection(){
        Wrapper[] buffer = new Wrapper[1];
        MPI.COMM_WORLD.Recv(buffer, 0, 1, MPI.OBJECT, 0, MPI.ANY_TAG);

        Wrapper w = buffer[0];

        Set<Integer> toBeRecolored = new HashSet<>();
        for(int i = w.start; i < w.end; i++){
            Node currentNode = w.graph.getNode(i);
            for(int neighbour: currentNode.getNeighbours()){
                if(currentNode.getColor() == w.graph.getNode(neighbour).getColor()){
                    toBeRecolored.add(Math.max(i, neighbour));
                }
            }
        }

        return toBeRecolored;
    }

    public static void modifyGraph(Graph graph, Wrapper w){
        for(int i = w.start; i < w.end; i++){
            graph.getNode(i).setColor(w.graph.getNode(i).getColor());
        }
    }

    public static void sendToRepeat(boolean toRepeat){
        Boolean[] buffer = new Boolean[1];
        buffer[0] = toRepeat;
        for(int i = 1; i < MPI.COMM_WORLD.Size(); i++){
            MPI.COMM_WORLD.Send(buffer, 0, 1, MPI.OBJECT, i, 0);
        }
    }

    public static boolean receiveToRepeat(){
        Object[] buffer = new Object[1];

        MPI.COMM_WORLD.Recv(buffer, 0, 1, MPI.OBJECT, 0, 0);

        return (Boolean) buffer[0];
    }
}

