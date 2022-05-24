import numpy as np
from utils import *
from random import *

class Ant:
    def __init__(self, droneMap):
        sensorEnergy = 0
        self.path = [(droneMap.x, droneMap.y, sensorEnergy)]
        self.map = droneMap
        self.spentEnergy = [[0 for _ in range(self.map.m)] for _ in range(self.map.n)]
        self.batteryLeft = droneMap.battery

    def fitness(self):
        marked = np.zeros((self.map.n, self.map.m))
        for cell in self.path:
            if cell[2] != 0:
                i = cell[0]
                j = cell[1]
                neighbours = [(i, j) for _ in range(4)]
                for _ in range(cell[2]):
                    for direction in range(len(Util.v)):
                        neigh = neighbours[direction]
                        neigh = Util.addDirections(neigh, Util.v[direction])
                        if not self.map.isWall(neigh):
                            marked[neigh[0]][neigh[1]] = 1
                            neighbours[direction] = neigh
        return sum([sum(row) for row in marked])

    # def nextMoves(self, position):
    #     new = []
    #     for i in range(4):
    #         nextX = x + Util.v[i][0]
    #         nextY = y + Util.v[i][1]
    #         if 0 <= nextX < self.__map.n and 0 <= nextY < self.__map.m and not self.__map.isWall((nextX, nextY)):
    #             new.append(nextX * self.__map.m + nextY)
    #     if not new:
    #         return []
    #     return new.copy()

    def addMove(self, trace):
        currentCell = (self.path[-1][0], self.path[-1][1])
        candidateNeighbours = []
        for direction in range(len(Util.v)):
            for spent in range(min(Util.maxSensorCapacity + 1, self.batteryLeft)):
                if (tau := trace[currentCell[0]][currentCell[1]][direction][spent]) != 0:
                    cost = (1 / (spent + 1)) ** Util.beta + tau ** Util.alpha
                    nextCell = [(currentCell[0] + Util.v[direction][0],
                                 currentCell[1] + Util.v[direction][1], spent), cost]
                    if self.spentEnergy[nextCell[0][0]][nextCell[0][1]] <= spent and nextCell[0] not in self.path:
                        candidateNeighbours.append(nextCell)

        if len(candidateNeighbours) == 0:
            return
        if random() < Util.q0:
            self.path.append(max(candidateNeighbours, key=lambda pair: pair[1])[0])
            self.batteryLeft -= self.path[-1][2] + 1
            self.spentEnergy[self.path[-1][0]][self.path[-1][1]] = self.path[-1][2]
        else:
            probabilitiesSum = sum([move[1] for move in candidateNeighbours])
            # nextPosition = np.random.choice([index for index in range(len(candidateNeighbours))],
            #                                    p=[position[1] / probabilitiesSum for position in candidateNeighbours])
            p = [move[1] / probabilitiesSum for move in candidateNeighbours]
            cdf = [sum(p[0:i + 1]) for i in range(len(p))]
            cdf.sort()
            r = random()
            i = 0
            while r > cdf[i]:
                i += 1
            self.path.append(candidateNeighbours[i][0])
            self.batteryLeft -= self.path[-1][2] + 1
            self.spentEnergy[self.path[-1][0]][self.path[-1][1]] = self.path[-1][2]
