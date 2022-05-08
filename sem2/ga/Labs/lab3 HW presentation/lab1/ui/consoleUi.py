import time


class ConsoleUi:
    def __init__(self, service):
        self._service = service

    @staticmethod
    def menu():
        print("\tAvailable commands:\n"
              "'read' - reads and loads the graph from input.txt .\n"
              "'write' - writes the graph to output.txt .\n"
              "'print' - prints the current graph .\n"
              "'create random' - create random graph .\n"
              "'add {'vertex'/'edge'}' - adds a vertex or an edge to the current graph .\n"
              "'remove {'vertex'/'edge'}' - removes an vertex or an edge from the current graph .\n"
              "'check {'vertex'/'edge'}' - Prints True if a vertex or an edge exists in the current graph, "
              "False otherwise.\n"
              "''get nr of vert'' - prints the nr of vert .\n"
              "''get nr of edges'' - prints the nr of edges .\n"
              "'get inbound' - prints the inbound edges and in degree number .\n"
              "'get outbound' - prints the outbound edges and out degree number .\n"
              "'get cost' - prints the cost of a given edge .\n"
              "'set cost' - sets the cost of a given edge to a given value .\n"
              "'shortest path' - displays the minimum length path between two vertices and the corresponding length.\n"
              "'lcw' - displays the lowest cost walk between two vertices and it's corresponding cost.\n"
              "'exit' - exit the application.\n")

    def uiReadFromTextFile(self):
        start = time.time()
        self._service.readGraphFromFile()
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiWriteGraphToFile(self):
        start = time.time()
        self._service.writeGraphToFile()
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiPrintGraph(self):
        start = time.time()
        print(self._service.graph)
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    @staticmethod
    def uiReadVertex():
        vertex = input('Give Vertex:').strip()
        if vertex.isnumeric() is False:
            raise ValueError('Give a positive number.')
        return int(vertex)

    @staticmethod
    def uiReadEdge():
        source, target = input('Give source vertex:').strip(), input('Give target vertex:').strip()
        if source.isnumeric() is False or target.isnumeric() is False:
            raise ValueError('Give a positive number.')
        return int(source), int(target)

    def uiCreateRandomGraph(self):
        vertices, edges = input('Give number of vertices:').strip(), input('Give number of edges:').strip()
        start = time.time()
        if vertices.isnumeric() is False or edges.isnumeric() is False:
            raise ValueError('Give a positive number.')
        self._service.createAndLoadRandomGraph(int(vertices), int(edges))
        print("Operation was successful")
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiAddVertex(self):
        vertex = self.uiReadVertex()
        start = time.time()
        self._service.graph.addVertex(vertex)
        print("Operation was successful")
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiAddEdge(self):
        source, target = self.uiReadEdge()
        start = time.time()
        cost = input('Give cost:').strip()
        if cost.isnumeric() is False:
            raise ValueError('Give a positive number.')
        self._service.graph.addEdge(source, target, int(cost))
        print("Operation was successful")
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiRemoveVertex(self):
        vertex = self.uiReadVertex()
        start = time.time()
        self._service.graph.removeVertex(vertex)
        print("Operation was successful")
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiRemoveEdge(self):
        source, target = self.uiReadEdge()
        start = time.time()
        self._service.graph.removeEdge(source, target)
        print("Operation was successful")
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiCheckVertex(self):
        vertex = self.uiReadVertex()
        print(self._service.graph.existingVertex(vertex))

    def uiCheckEdge(self):
        source, target = self.uiReadEdge()
        print(self._service.graph.existingEdge(source, target))

    def uiGetCost(self):
        target, source = self.uiReadEdge()
        print(self._service.graph.getCost(target, source))

    def uiSetCost(self):
        target, source = self.uiReadEdge()
        cost = input('Give cost:').strip()
        if cost.isnumeric() is False:
            raise ValueError('Give a positive number.')
        print(self._service.graph.setCost(target, source, cost))
        print("Operation was successful")

    def uiGetInbound(self):
        vertex = self.uiReadVertex()
        start = time.time()
        print("Nr of inbound:", self._service.graph.getInDegree(vertex))
        lst = list(self._service.graph.inboundEdge(vertex))
        print(lst)
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiGetOutbound(self):
        vertex = self.uiReadVertex()
        start = time.time()
        print("Nr of outbound:", self._service.graph.getOutDegree(vertex))
        lst = list(self._service.graph.outboundEdge(vertex))
        print(lst)
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiGetNrOfVert(self):
        start = time.time()
        print(self._service.graph.nrOfVertices)
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiGetNrOfEdges(self):
        start = time.time()
        print(self._service.graph.nrOfEdges)
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiShortestPath(self):
        target, source = self.uiReadEdge()
        start = time.time()
        path = self._service.graph.shortestPath(target, source)
        if path is None:
            print("There is no path!")
        else:
            print(path)
            print("Length:", len(path) - 1)
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def uiLowestCostWalk(self):
        target, source = self.uiReadEdge()
        start = time.time()
        path = self._service.graph.lowestCostWalk(target, source)
        if path is None:
            print("There is no path!")
        else:
            print(path)
            print("Cost:", self._service.graph.costOfPath(path))
        end = time.time()
        print("Command took", end - start, "to execute.\n")

    def run(self):
        commandDict = {'read': self.uiReadFromTextFile, 'write': self.uiWriteGraphToFile, 'print': self.uiPrintGraph,
                       'create random': self.uiCreateRandomGraph, 'add vertex': self.uiAddVertex,
                       'add edge': self.uiAddEdge, 'remove vertex': self.uiRemoveVertex,
                       'remove edge': self.uiRemoveEdge, 'check vertex': self.uiCheckVertex,
                       'check edge': self.uiCheckEdge, 'get cost': self.uiGetCost, 'set cost': self.uiSetCost,
                       'get inbound': self.uiGetInbound, 'get outbound': self.uiGetOutbound,
                       'get nr of vert': self.uiGetNrOfVert, 'get nr of edge': self.uiGetNrOfEdges,
                       'shortest path': self.uiShortestPath, 'lcw': self.uiLowestCostWalk}
        while True:
            self.menu()
            command = input(">").lower().strip()
            if command in commandDict:
                try:
                    commandDict[command]()
                except Exception as e:
                    print(e)
            elif command == 'exit':
                break
            else:
                print("Enter an available command.")
