from repo.directedGraph import DirectedGraph, EdgeError
from random import randint


class StoreException(Exception):
    pass


class RandomGraphError(StoreException):
    pass


class GraphService:
    def __init__(self):
        self._graph = None
        self._visited = []

    @property
    def graph(self):
        return self._graph

    def readGraphFromFile(self, fileName="input.txt"):
        f = open(fileName, 'rt')
        lines = f.readlines()
        f.close()
        n, m = lines[0].split(" ")
        dg = DirectedGraph(int(n))
        for e in range(1, int(m) + 1):
            t, s, c = lines[e].split(" ")
            dg.addEdge(int(t), int(s), int(c))
        self._graph = dg

    def writeGraphToFile(self, fileName="output.txt"):
        f = open(fileName, 'wt')
        f.write(str(self._graph.nrOfVertices) + " " + str(self._graph.nrOfEdges) + "\n")
        for edge in self._graph.edges:
            f.write(str(edge[0]) + " " + str(edge[1]) + " " + str(self._graph.getCost(edge[0], edge[1])) + "\n")
        f.close()

    @staticmethod
    def createRandomGraph(nrOfVertices, nrOfEdges):
        if nrOfVertices * nrOfVertices < nrOfEdges:
            raise RandomGraphError("Number of edges too large for the number of vertices.")
        newGraph = DirectedGraph(nrOfVertices)
        error = 0
        while newGraph.nrOfEdges < nrOfEdges and error < 100000:
            target, source, cost = randint(0, nrOfVertices-1), randint(0, nrOfVertices-1), randint(1, 100)
            try:
                newGraph.addEdge(target, source, cost)
                error += 1
            except EdgeError:
                pass
        return newGraph

    def createAndLoadRandomGraph(self, nrOfVertices, nrOfEdges):
        self._graph = self.createRandomGraph(nrOfVertices, nrOfEdges)
