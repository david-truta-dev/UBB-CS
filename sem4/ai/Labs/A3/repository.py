# -*- coding: utf-8 -*-
from domain import *


class Repository:
    def __init__(self):
        self.__populations = []
        self.cmap = Map()
        self.drone = [0, 0]

    @staticmethod
    def createPopulation(populationSize, numOfSteps):
        return Population(populationSize, numOfSteps)

    def addPopulation(self, population):
        self.__populations.append(population)

    def currentPopulation(self):
        return self.__populations[-1]

    def computeAverageFitnessAndDeviation(self):
        return self.__populations[-1].computeAverageFitnessAndDeviation(self.cmap, self.drone)

    def evaluatePopulation(self, population):
        population.evaluate(self.cmap, self.drone)

    def computeBestFitnessLatestPopulation(self):
        return self.__populations[-1].getBestFitness(self.cmap, self.drone)

    def setDronePositions(self, x, y):
        self.drone = [x, y]

    def getDronePositions(self):
        return self.drone

    def addIndividual(self, population, individual):
        population.addIndividual(individual, self.cmap, self.drone)

    def randomDrone(self):
        x = randint(0, self.cmap.n - 1)
        y = randint(0, self.cmap.m - 1)
        while self.cmap.surface[x][y] != 0:
            x = randint(0, self.cmap.n - 1)
            y = randint(0, self.cmap.m - 1)
        # self.drone = [x, y]
        print("COORDS", x, y)
        self.setDronePositions(x, y)

    def getFirstPath(self):
        return self.__populations[-1].getFirstPath(self.cmap, self.drone)
