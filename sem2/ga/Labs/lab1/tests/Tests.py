from unittest import TestCase

from repo.directedGraph import DirectedGraph, VertexError, EdgeError
from service.graphService import GraphService, RandomGraphError


class DomainTest(TestCase):

    def test_graph(self):
        g = DirectedGraph(7)
        g.addVertex(7)
        g.addEdge(0, 1)
        g.addEdge(1, 1)
        g.addEdge(1, 5)
        g.addEdge(2, 1)
        g.addEdge(3, 1)
        g.addEdge(5, 1)
        print(g)
        self.assertEqual(g.existingEdge(0, 1), True)
        self.assertEqual(g.existingEdge(1, 0), False)
        self.assertEqual(g.nrOfEdges, 6)
        self.assertEqual(g.nrOfVertices, 8)
        self.assertEqual(g.vertices, [0, 1, 2, 3, 4, 5, 6, 7])
        self.assertRaises(VertexError, g.addVertex, 4)
        self.assertRaises(EdgeError, g.addEdge, 7, 8)
        self.assertRaises(EdgeError, g.addEdge, 0, 1)
        print(g)
        g.removeEdge(1, 1)
        self.assertEqual(g.existingEdge(1, 1), False)
        self.assertEqual(g.nrOfEdges, 5)
        self.assertRaises(EdgeError, g.removeEdge, 1, 0)

        g.removeVertex(1)
        self.assertEqual(g.nrOfEdges, 0)
        self.assertEqual(g.nrOfVertices, 7)
        self.assertRaises(VertexError, g.removeVertex, 9)

        g.addEdge(3, 2)
        g.addEdge(6, 2)
        g.addEdge(3, 7)
        self.assertEqual(g.getInDegree(2), 2)
        self.assertEqual(g.getInDegree(7), 1)
        self.assertEqual(g.getInDegree(6), 0)
        self.assertEqual(g.getOutDegree(3), 2)
        self.assertEqual(g.getOutDegree(2), 0)

        g.setCost(3, 2, 1)
        self.assertEqual(1, g.getCost(3, 2))

        # ========= Copyable

        g2 = g.copyOfGraph()
        g.removeVertex(7)
        g2.removeEdge(3, 2)
        print(g)
        print(g2)
        self.assertFalse(g.__str__() == g2.__str__())

        # ========== Seminar ========
        for x in g.vertices:  # this parses all vertices
            line = str(x) + " :"
            for y in g.outboundEdge(x):
                line = line + " " + str(y)
            print(line)

        print()
        for x in g.vertices:  # this parses all vertices
            line = str(x) + " :"
            for y in g.inboundEdge(x):
                line = line + " " + str(y)
            print(line)

        # ========== BFS ===============
        # 2. Write a program that, given a directed graph and two vertices, finds a lowest length path between them,
        # by using a backward breadth-first search from the ending vertex.

    def test_graph_service(self):
        service = GraphService()
        gr = service.createRandomGraph(7, 20)
        print(gr)
        self.assertEqual(gr.nrOfEdges, 20)
        self.assertEqual(gr.nrOfVertices, 7)

        self.assertRaises(RandomGraphError, service.createRandomGraph, 6, 40)
