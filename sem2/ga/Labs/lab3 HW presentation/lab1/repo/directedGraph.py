import heapq


class StoreException(Exception):
    pass


class VertexError(StoreException):
    pass


class EdgeError(StoreException):
    pass


class DirectedGraph:
    def __init__(self, n=0):
        self._dIn = {}
        self._dOut = {}
        self.__createVertices(n)
        self._edges = {}

    def __createVertices(self, n):
        for i in range(n):
            self._dIn[i] = []
            self._dOut[i] = []

    # ================================== Getter/Setters

    @property
    def nrOfVertices(self):
        return len(self._dIn)

    @property
    def nrOfEdges(self):
        return len(self._edges)

    @property
    def vertices(self):
        return list(self._dIn.keys())

    @property
    def edges(self):
        return list(self._edges.keys())

    def getCost(self, source, target):
        """
        Returns the cost of the edge between source and target
        :param source: a vertex(int)
        :param target: a vertex(int)
        :return: the cost of the edge between source and target(int)
        Rasies Exception if there is no edge between source and target
        """
        if self.existingEdge(source, target) is False:
            raise EdgeError("There is no Edge between these vertices.")
        return self._edges[(source, target)]

    def setCost(self, source, target, cost):
        """
        Sets the cost of the edge between source and target, if the edge exists.
        :param cost: cost
        :param source: a vertex(int)
        :param target: a vertex(int)
        :return:-
        Rasies Exception if there is no edge between source and target
        """
        if self.existingEdge(source, target) is False:
            raise EdgeError("There is no Edge between these vertices.")
        self._edges[(source, target)] = cost

    def inboundEdge(self, vertex):
        """
        Returns a generator that can be converted to list, which is iterable and contains all inbound edges of vertex.
        :param vertex: a vertex(int)
        :return: generator
        """
        for v in self._dIn[vertex]:
            yield v

    def outboundEdge(self, vertex):
        """
        Returns a generator that can be converted to list, which is iterable and contains all outbound edges of vertex.
        :param vertex: a vertex(int)
        :return: generator
        """
        for v in self._dOut[vertex]:
            yield v

    def getInDegree(self, vertex):
        if self.existingVertex(vertex) is False:
            raise VertexError("This vertex doesn't exist")
        """
        Returns the in degree of a vertex.
        :param vertex: a vertex(int)
        :return: (int) In degree of vertex
        """
        return len(self._dIn[vertex])

    def getOutDegree(self, vertex):
        if self.existingVertex(vertex) is False:
            raise VertexError("This vertex doesn't exist")
        """
        Returns the out degree of a vertex.
        :param vertex: a vertex(int)
        :return: (int) Out degree of vertex
        """
        return len(self._dOut[vertex])

    # ======================================= Functionalities

    def existingVertex(self, vertex):
        """
        Returns whether a vertex exists or not.
        :param vertex:a vertex(int)
        :return: True if the vertex exists, False otherwise
        """
        if vertex in self._dIn.keys():
            return True
        return False

    def addVertex(self, vertex):
        """
        Adds a vertex to the graph.
        :param vertex: a vertex(int)
        :return:-
        Raises VertexError if the vertex already exists
        """
        if self.existingVertex(vertex) is True:
            raise VertexError("This vertex already exists! ")
        self._dIn[vertex] = []
        self._dOut[vertex] = []

    def removeVertex(self, vertex):
        """
        Removes a vertex to the graph.
        :param vertex: a vertex(int)
        :return:
         Raises VertexError if the vertex doesn't exists
        """
        if self.existingVertex(vertex) is False:
            raise VertexError("This vertex doesn't exist")
        # Removing edges that go in V
        for v in self._dOut[vertex]:
            self._edges.pop((vertex, v))
            self._dIn[v].remove(vertex)
        # Removing V from 'out' lists of every vertex that is in 'in' list of vertex AND the edge between them
        for v in self._dIn[vertex]:
            self._edges.pop((v, vertex))
            self._dOut[v].remove(vertex)
        # Removing V from dict of vertices
        self._dIn.pop(vertex)
        self._dOut.pop(vertex)

    def __insertVertex(self, source, target):
        """
        Helping function, it inserts vertices of an edge in the dictionaries.
        :param source: a vertex(int)
        :param target: a vertex(int)
        :return:-
        """
        self._dOut[source].append(target)
        self._dIn[target].append(source)

    def existingEdge(self, source, target):
        """
        Returns whether an edge exists or not.
        :param source:  a vertex(int)
        :param target:  a vertex(int)
        :return: True if the edge exists, False otherwise
        """
        if source in self._dIn[target]:
            return True
        return False

    def addEdge(self, source, target, cost=None):
        """
        Adds an edge to the graph.
        :param source: a vertex(int)
        :param target:a vertex(int)
        :param cost: The cost of the edge(int)
        :return:-
        Raises EdgeError if the edge already exists or if the vertices do not exist.
        """
        if self.existingVertex(source) is False or self.existingVertex(target) is False:
            raise EdgeError("Vertices or vertex of edge don't exist.")
        if self.existingEdge(source, target) is True:
            raise EdgeError(
                "This edge already exists. " + str((source, target)) + " " + str(self._edges[(source, target)]))
        self.__insertVertex(source, target)
        self._edges[(source, target)] = cost

    def removeEdge(self, source, target):
        """
        Removes an edge from the graph.
        :param source:a vertex(int)
        :param target:a vertex(int)
        :return:-
        Raises EdgeError if the edge does not exists.
        """
        if self.existingEdge(source, target) is False:
            raise EdgeError("This edge doesn't exist")
        self._dOut[source].remove(target)
        self._dIn[target].remove(source)
        self._edges.pop((source, target))

    def copyOfGraph(self):
        """
        Creates and returns a deepcopy of the Graph.
        :return: an instance of the DirectedGraph Class
        """
        newG = DirectedGraph()
        for v in self._dIn.keys():
            newG.addVertex(v)
        for edge in self._edges.keys():
            newG.addEdge(edge[0], edge[1], self._edges[edge])
        return newG

    @staticmethod
    def createList(source, target, next):
        res = []
        v = source
        while next[v] != target:
            res.append(v)
            v = next[v]
        res.append(v)
        res.append(target)
        return res

    def costOfPath(self, nodes):
        sum = 0
        for i in range(len(nodes) - 1):
            sum += self._edges[(nodes[i], nodes[i+1])]
        return sum

    def shortestPath(self, source, target):
        queue, next, visited = [target], {}, {}
        for v in range(self.nrOfVertices):
            visited[v] = False
        while len(queue) > 0:
            v = queue.pop(0)
            for v2 in self._dIn[v]:
                if visited[v2] is False:
                    queue.append(v2)
                    visited[v2] = True
                    next[v2] = v
                    if v2 == source:
                        return self.createList(source, target, next)
        if source not in visited:
            return None
        return self.createList(source, target, next)

    def lowestCostWalk(self, source, target):
        pQ, next, dist, found = [], {}, {}, False
        heapq.heappush(pQ, (0, target))
        dist[target] = 0
        while len(pQ) > 0 and not found:
            v = heapq.heappop(pQ)[1]

            for v2 in self._dIn[v]:
                if v2 not in dist or dist[v] + self._edges[(v2, v)] < dist[v2]:
                    dist[v2] = dist[v] + self._edges[(v2, v)]
                    heapq.heappush(pQ, (dist[v2], v2))
                    next[v2] = v
            if v == source:
                return self.createList(source, target, next)
        return None

    def __str__(self):
        edges = ""
        for edge in self._edges:
            edges += "   " + str(edge) + " " + str(self._edges[edge]) + "\n"
        return "==========" \
               "========================" \
               "========\n" + "Nr of Vertices:" \
                              " {:<10}  Nr of Edges: {:<10}\n" \
                              " Edges:\n".format(self.nrOfVertices, self.nrOfEdges) + edges
