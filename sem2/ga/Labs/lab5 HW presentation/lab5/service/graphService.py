from repo.directedGraph import UndirectedGraph


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
        dg = UndirectedGraph(int(n))
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

    def kruskal(self):
        # Graph that contains all vertices:
        newGraph = UndirectedGraph(self._graph.nrOfVertices)
        # All it's edges, ordered by cost:
        newEdges, index = sorted(self.graph.getAllEdges.items(), key=lambda x: x[1]), 0
        while newGraph.nrOfEdges < self._graph.nrOfVertices - 1:
            try:
                res = newGraph.shortestPath(newEdges[index][0][0], newEdges[index][0][1])
                if res is None:
                    newGraph.addEdge(newEdges[index][0][0], newEdges[index][0][1], newEdges[index][1])
            except Exception:
                newGraph.addEdge(newEdges[index][0][0], newEdges[index][0][1], newEdges[index][1])
            index += 1
        return newGraph

    @staticmethod
    def moreThan2EdgesAtVertex(newGraph, newEdges, index):
        if newGraph.existingVertex(newEdges[index][0][0]) and newGraph.getDegree(
                newEdges[index][0][0]) < 2 or newGraph.existingVertex(newEdges[index][0][0]) is False:
            if newGraph.existingVertex(newEdges[index][0][1]) and newGraph.getDegree(
                    newEdges[index][0][1]) < 2 or newGraph.existingVertex(newEdges[index][0][1]) is False:
                return False
        return True

    def HamiltonCycleLowCost(self):
        # Graph that contains all vertices:
        newGraph = UndirectedGraph(self._graph.nrOfVertices)
        # All it's edges, ordered by cost:
        newEdges, index = sorted(self.graph.getAllEdges.items(), key=lambda x: x[1]), 0
        while index < self._graph.nrOfEdges:
            try:
                res = newGraph.shortestPath(newEdges[index][0][0], newEdges[index][0][1])
                print(res)
                if res is not None:
                    if len(res) >= newGraph.nrOfVertices:
                        newGraph.addEdge(newEdges[index][0][0], newEdges[index][0][1], newEdges[index][1])
                        return newGraph
                else:
                    if self.moreThan2EdgesAtVertex(newGraph, newEdges, index) is False:
                        newGraph.addEdge(newEdges[index][0][0], newEdges[index][0][1], newEdges[index][1])
            except Exception:
                if self.moreThan2EdgesAtVertex(newGraph, newEdges, index) is False:
                    newGraph.addEdge(newEdges[index][0][0], newEdges[index][0][1], newEdges[index][1])
            index += 1
        return None

