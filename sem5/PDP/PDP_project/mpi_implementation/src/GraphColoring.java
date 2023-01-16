import mpi.MPI;

import java.util.*;


public class GraphColoring {
    public static Map<Integer, String> graphColoringMain(int mpiSize, DirectedGraph graph, ColorsGraph colors) {
        int codesNo = colors.getColorsNo();
        int[] codes = graphColoringRec(0, graph, codesNo, new int[graph.getNodesNo()], 0, mpiSize, 0);

        // no solution
        if (codes[0] == -1) {
            throw new GraphColoringException("No solution found!");
        }

        //solution
        return colors.getNodesToColors(codes);
    }

    private static int[] graphColoringRec(int node, DirectedGraph graph, int codesNo, int[] codes, int mpiMe, int mpiSize, int power) {
        int nodesNo = graph.getNodesNo();

        //invalid solution
        if (!isCodeValid(node, codes, graph)) {
            return getArrayOf(nodesNo,  -1);
        }

        //valid solution
        if (node + 1 == graph.getNodesNo()) {
            return codes;
        }

        //valid destination processes
        int coefficient = (int) Math.pow(codesNo, power);
        int code = 0;
        int destination = mpiMe + coefficient * (code + 1);

        while (code + 1 < codesNo && destination < mpiSize) {
            code++;
            destination = mpiMe + coefficient * (code + 1);
        }

        //send data to destination processes
        int nextNode = node + 1;
        int nextPower = power + 1;

        for (int currentCode = 1; currentCode < code; currentCode++) {
            destination = mpiMe + coefficient * currentCode;

            int[] data = new int[]{mpiMe, nextNode, nextPower};
            MPI.COMM_WORLD.Send(data, 0, data.length, MPI.INT, destination, 0);

            int[] nextCodes = getArrayCopy(codes);
            nextCodes[nextNode] = currentCode;

            MPI.COMM_WORLD.Send(nextCodes, 0, nodesNo, MPI.INT, destination, 0);
        }

        //try code 0 for next node on this process
        int[] nextCodes = getArrayCopy(codes);
        nextCodes[nextNode] = 0;

        int[] result = graphColoringRec(nextNode, graph, codesNo, nextCodes, mpiMe, mpiSize, nextPower);
        if (result[0] != -1) {
            return result;
        }

        //recv data from destination processes
        for (int currentCode = 1; currentCode < code; currentCode++) {
            destination = mpiMe + coefficient * currentCode;

            result = new int[nodesNo];
            MPI.COMM_WORLD.Recv(result, 0, nodesNo, MPI.INT, destination, MPI.ANY_TAG);

            if (result[0] != -1) {
                return result;
            }
        }

        //try the remaining codes for next node on this process (if any)
        for (int currentCode = code; currentCode < codesNo; currentCode++) {
            nextCodes = getArrayCopy(codes);
            nextCodes[nextNode] = currentCode;

            result = graphColoringRec(nextNode, graph, codesNo, nextCodes, mpiMe, mpiSize, nextPower);
            if (result[0] != -1) {
                return result;
            }
        }

        //invalid solution (result is an array of -1)
        return result;
    }

    public static void graphColoringWorker(int mpiMe, int mpiSize, DirectedGraph graph, int codesNo) {
        int nodesNo = graph.getNodesNo();

        //recv data
        int[] data = new int[3];
        MPI.COMM_WORLD.Recv(data, 0, data.length, MPI.INT, MPI.ANY_SOURCE, MPI.ANY_TAG);

        int parent = data[0];
        int node = data[1];
        int power = data[2];

        int[] codes = new int[nodesNo];
        MPI.COMM_WORLD.Recv(codes, 0, nodesNo, MPI.INT, MPI.ANY_SOURCE, MPI.ANY_TAG);

        //rec. call
        int[] newCodes = graphColoringRec(node, graph, codesNo, codes, mpiMe, mpiSize, power);

        //send data
        MPI.COMM_WORLD.Send(newCodes, 0, nodesNo, MPI.INT, parent, 0);
    }

    private static boolean isCodeValid(int node, int[] codes, DirectedGraph graph) {
        for (int currentNode = 0; currentNode < node; currentNode++)
            if ((graph.isVertex(node, currentNode) || graph.isVertex(currentNode, node)) && codes[node] == codes[currentNode])
                return false;

        return true;
    }

    private static int[] getArrayOf(int length, int value) {
        int[] array = new int[length];
        Arrays.fill(array, value);

        return array;
    }

    private static int[] getArrayCopy(int[] array) {
        return Arrays.copyOf(array, array.length);
    }
}
