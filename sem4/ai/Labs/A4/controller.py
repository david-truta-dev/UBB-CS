import time
from random import randint

from domain import Ant


class Controller:
    def __init__(self, repo):
        self.repository = repo
        self._energy = None
        self._nrOfSensors = None
        self._sensors = []
        self._m = self.repository.map.n
        self._n = self.repository.map.m
        self._noOfAnts = 10
        self._alpha = 1.9
        self._beta = 0.9
        self._q0 = 0.5
        self._rho = 0.05
        self._trace = None

    def setDronePosition(self, x, y):
        self.repository.setDronePositions(x, y)

    def getDronePosition(self):
        return self.repository.getDronePositions()

    def setEnergy(self, e):
        self._energy = e

    def getEnergy(self):
        return self._energy

    def setNumberOfSensors(self, sensors):
        self._nrOfSensors = sensors

    def getNumberOfSensors(self):
        return self._nrOfSensors

    def setSensors(self, sensors):
        self._sensors = sensors

    def getSensors(self):
        return self._sensors

    def getSensorDetection(self):
        res = []
        for sensor in self._sensors:
            forOneSensor = []
            for value in range(6):
                forOneSensor.append(self.repository.getDetectedSquares(sensor, value))
            res.append(forOneSensor)
        return res

    def epoch(self):
        antSet = [Ant(self._n, self._m) for i in range(self._noOfAnts)]
        for i in range(self._n * self._m):
            # numarul maxim de iteratii intr-o epoca este lungimea solutiei
            for x in antSet:
                x.addMove(self._q0, self._trace, self._alpha, self._beta)
        # actualizam trace-ul cu feromonii lasati de toate furnicile
        dTrace = [1.0 / antSet[i].fitness() for i in range(len(antSet))]
        for i in range(self._n * self._m):
            for j in range(self._n * self._m):
                self._trace[i][j] = (1 - self._rho) * self._trace[i][j]
        for i in range(len(antSet)):
            for j in range(len(antSet[i].path) - 1):
                x = antSet[i].path[j]
                y = antSet[i].path[j + 1]
                self._trace[x][y] = self._trace[x][y] + dTrace[i]
        # return best ant path
        f = [[antSet[i].fitness(), i] for i in range(len(antSet))]
        f = max(f)
        return antSet[f[1]].path

    def computeShortestPath(self, sensor1, sensor2, noEpoch=50):
        bestSol = []
        self._trace = [[1 for i in range(self._n * self._m)] for j in range(self._n * self._m)]
        for i in range(noEpoch):
            sol = self.epoch().copy()
            if len(sol) > len(bestSol):
                bestSol = sol.copy()


    def getShortestPathBetweenSensors(self):
        res1 = {}
        res2 = {}
        for i in range(self._nrOfSensors):
            for j in range(i + 1, self._nrOfSensors):
                shortestPath = self.computeShortestPath(self._sensors[i], self._sensors[j])
                res2[(self._sensors[i], self._sensors[j])] = shortestPath
                res1[(self._sensors[i], self._sensors[j])] = len(shortestPath)
        return res1, res2
