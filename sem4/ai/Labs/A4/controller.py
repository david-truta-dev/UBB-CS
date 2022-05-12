from domain.Map import Map
from domain.Ant import Ant
from utils import *
from copy import deepcopy
import numpy as np


class Controller:
    def __init__(self):
        self.map = Map()
        self.pheromoneMatrix = []
        for i in range(self.map.n):
            self.pheromoneMatrix.append([])
            for j in range(self.map.m):
                self.pheromoneMatrix[-1].append([])
                for direction in Util.v:
                    neigh = [i + direction[0], j + direction[1]]
                    if not self.map.isWall(neigh):
                        if self.map.surface[neigh[0]][neigh[1]] == 2:
                            self.pheromoneMatrix[-1][-1].append([5 for _ in range(Util.maxSensorCapacity + 1)])
                        else:
                            self.pheromoneMatrix[-1][-1].append([1.0] + [0 for _ in range(Util.maxSensorCapacity)])
                    else:
                        self.pheromoneMatrix[-1][-1].append([0 for _ in range(Util.maxSensorCapacity + 1)])
        self.initialPheromoneMatrix = deepcopy(self.pheromoneMatrix)

    def epoch(self):
        population = []
        for i in range(Util.numberOfAnts):
            ant = Ant(self.map)
            population.append(ant)

        for i in range(self.map.battery):
            for ant in population:
                ant.addMove(self.pheromoneMatrix)
        for i in range(self.map.n):
            for j in range(self.map.m):
                for direction in Util.v:
                    for spent in range(Util.maxSensorCapacity + 1):
                        self.pheromoneMatrix[i][j][Util.v.index(direction)][spent] *= (1 - Util.rho)
                        self.pheromoneMatrix[i][j][Util.v.index(direction)][spent] += Util.rho * \
                                                                                      self.initialPheromoneMatrix[i][j][
                                                                                          Util.v.index(direction)][
                                                                                          spent]

        bestAnt = population[max([[population[i].fitness(), i] for i in range(len(population))])[1]]
        bestFitness = bestAnt.fitness()

        for ant in population:
            antFitness = ant.fitness()
            for i in range(len(ant.path) - 1):
                x = ant.path[i]
                y = ant.path[i + 1]
                directionIndex = Util.v.index((y[0] - x[0], y[1] - x[1]))
                self.pheromoneMatrix[x[0]][x[1]][directionIndex][y[2]] += (antFitness + 1) / (bestFitness + 1)

        return bestAnt, np.mean([ant.fitness() for ant in population])

    def computeACO(self):
        solution = None
        fitnesses = []
        for i in range(Util.numberOfEpochs):
            if i % 60 == 0:
                print()
            print(i, end=" ")
            current, fitness = self.epoch()
            fitnesses.append(fitness)
            # print(current.path)
            if solution is None or solution.fitness() < current.fitness():
                solution = current
        print(solution.fitness())
        return solution, fitnesses
