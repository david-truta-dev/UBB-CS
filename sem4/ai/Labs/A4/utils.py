# -*- coding: utf-8 -*-
import math


class Util:
    @staticmethod
    def addDirections(x, y):
        return (x[0] + y[0]), (x[1] + y[1])

    @staticmethod
    def getManhattanDistance(p1, p2):
        return abs(p1[0] - p2[0]) + abs(p1[1] - p2[1])

    @staticmethod
    def getEuclideanDistance(p1, p2):
        return math.sqrt((p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2)

    # Creating some colors
    BLUE = (0, 0, 255)
    GRAYBLUE = (50, 120, 120)
    RED = (255, 0, 0)
    GREEN = (0, 255, 0)
    BLACK = (0, 0, 0)
    WHITE = (255, 255, 255)

    # define directions
    UP = 0
    DOWN = 2
    LEFT = 1
    RIGHT = 3

    # define indexes variations
    v = [(-1, 0), (1, 0), (0, 1), (0, -1)]

    # define mapsize

    mapLength = 20

    initialPosition = (7, 12)
    batteryCapacity = 75
    numberOfSensors = 5
    numberOfAnts = 80
    numberOfEpochs = 100
    alpha = 0.8
    beta = 1.5
    rho = 0.05
    q0 = 0.5
    maxSensorCapacity = 5
