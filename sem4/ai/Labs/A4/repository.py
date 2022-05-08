# -*- coding: utf-8 -*-
from random import *

from domain import Map
from utils import *


class Repository:
    def __init__(self):
        self.map = Map()
        self.drone = [0, 0]

    def setDronePositions(self, x, y):
        self.drone = [x, y]

    def getDronePositions(self):
        return self.drone

    def randomDrone(self):
        x = randint(0, self.map.n - 1)
        y = randint(0, self.map.m - 1)
        while self.map.surface[x][y] != 0:
            x = randint(0, self.map.n - 1)
            y = randint(0, self.map.m - 1)
        # self.drone = [x, y]
        print("COORDS", x, y)
        self.setDronePositions(x, y)

    def validSquare(self, x, y):
        if x < 0 or y < 0 or x >= self.map.n or y >= self.map.m or self.map.surface[y][x] != 0:
            return False
        return True

    def getDetectedSquares(self, sensor, value):
        detected = 0
        for i in range(4):
            j = 1
            while j <= value and self.__validSquare(v[i][0] * j + sensor[0], v[i][1] * j + sensor[1]):
                detected += 1
                j += 1
        return detected
