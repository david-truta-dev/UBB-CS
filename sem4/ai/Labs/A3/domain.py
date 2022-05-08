# -*- coding: utf-8 -*-
import copy
import pickle
from random import *
from utils import *
import numpy as np


class Individual:
    def __init__(self, size=0):
        self.__size = size
        self.__x = [randint(0, 3) for _ in range(self.__size)]
        self.f = None

    @staticmethod
    def distance(x, y, xfinal, yfinal):
        return abs(x - xfinal) + abs(y - yfinal)

    def fitness(self, currentMap, drone):
        self.f = 0
        path = self.computePath(currentMap, drone)
        visited = []
        for i in range(len(path)):
            x = path[i][0]
            y = path[i][1]
            if [x, y] not in visited:
                visited.append([x, y])
                if 0 > x or 0 > y or x >= currentMap.n or y >= currentMap.m or currentMap.surface[x][y] == 1:
                    break

                self.f += 1
                for var in v:
                    while ((0 <= x + var[0] < currentMap.n and 0 <= y + var[1] < currentMap.m) and
                           currentMap.surface[x + var[0]][y + var[1]] != 1):
                        if [x + var[0], y + var[1]] not in visited:
                            visited.append([x + var[0], y + var[1]])
                            self.f += 1
                        x = x + var[0]
                        y = y + var[1]

        self.f = self.f - MF * self.distance(path[0][0], path[0][1], path[-1][0], path[-1][1])

    def computePath(self, currentMap, drone):
        path = [[drone[0], drone[1]]]
        for i in self.__x:
            path.append([path[-1][0] + v[i][0], path[-1][1]+v[i][1]])

        valid_path = []
        for p in path:
            if 0 > p[0] or 0 > p[1] or p[0] >= currentMap.n or\
                    p[1] >= currentMap.m or currentMap.surface[p[0]][p[1]] == 1:
                break
            valid_path.append(p)

        return valid_path

    def mutate(self, mutateProbability=0.04):
        if random() < mutateProbability:
            self.__x[randint(0, self.__size - 1)] = randint(0, 3)

    def crossover(self, otherParent, crossoverProbability=0.8):
        offspring1, offspring2 = Individual(self.__size), Individual(self.__size)
        if random() < crossoverProbability:
            position = randint(0, self.__size - 1)
            offspring1.__x = otherParent.__x[:position] + self.__x[position:]
            offspring2.__x = self.__x[:position] + otherParent.__x[position:]

        return offspring1, offspring2


class Population:
    def __init__(self, populationSize=0, individualSize=0):
        self.__populationSize = populationSize
        self.__individuals = [Individual(individualSize) for _ in range(populationSize)]

    def computeAverageFitnessAndDeviation(self, map, drone):
        fitness = []
        for x in self.__individuals:
            x.fitness(map, drone)
            fitness.append(x.f)
        return [np.average(fitness), np.std(fitness)]

    def evaluate(self, mp, drone):
        for x in self.__individuals:
            x.fitness(mp, drone)

    def size(self):
        return len(self.__individuals)

    def setIndividuals(self, individuals):
        self.__individuals = individuals

    def addIndividual(self, individual, map, drone):
        individual.fitness(map, drone)
        self.__individuals.append(individual)

    def selection(self, k=0):
        individuals_copy = copy.deepcopy(self.__individuals)
        individuals_copy = self.sortIndividuals(individuals_copy)

        return individuals_copy[:k]

    @staticmethod
    def sortIndividuals(individuals):
        is_sorted = False
        while not is_sorted:
            is_sorted = True
            for i in range(0, len(individuals) - 1):
                if individuals[i].f < individuals[i + 1].f:
                    aux = individuals[i]
                    individuals[i] = individuals[i + 1]
                    individuals[i + 1] = aux
                    is_sorted = False
        return individuals

    def getFirstPath(self, map, drone):
        self.evaluate(map, drone)
        individuals_copy = copy.deepcopy(self.__individuals)
        individuals_copy = self.sortIndividuals(individuals_copy)
        return individuals_copy[0].computePath(map, drone)

    def getBestFitness(self, map, drone):
        self.evaluate(map, drone)
        individuals_copy = copy.deepcopy(self.__individuals)
        individuals_copy = self.sortIndividuals(individuals_copy)
        return individuals_copy[0].f


class Map:
    def __init__(self, n=20, m=20):
        self.n = n
        self.m = m
        self.surface = np.zeros((self.n, self.m))

    def randomMap(self, fill=0.2):
        for i in range(self.n):
            for j in range(self.m):
                if random() <= fill:
                    self.surface[i][j] = 1

    def loadMap(self, mapName):
        with open(mapName, "rb") as f:
            dummy = pickle.load(f)
            self.n = dummy.n
            self.m = dummy.m
            self.surface = dummy.surface
            f.close()

    def saveMap(self, mapName):
        with open(mapName, 'wb') as f:
            pickle.dump(self, f)
            f.close()

    def __str__(self):
        string = ""
        for i in range(self.n):
            for j in range(self.m):
                string = string + str(int(self.surface[i][j]))
            string = string + "\n"
        return string
