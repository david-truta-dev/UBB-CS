from utils import *
from random import *
import numpy as np
import pygame

class Map:
    def __init__(self):
        self.n = Util.mapLength
        self.m = Util.mapLength
        self.surface = np.zeros((self.n, self.m))
        self.randomMap()
        self.x, self.y = Util.initialPosition
        self.battery = Util.batteryCapacity

    def randomMap(self, fill=0.2):
        for i in range(self.n):
            for j in range(self.m):
                if random() <= fill:
                    self.surface[i][j] = 1

        for i in range(Util.numberOfSensors):
            sx = randint(0, self.n - 1)
            sy = randint(0, self.m - 1)
            while self.surface[sx][sy] == 1:
                sx = randint(0, self.n - 1)
                sy = randint(0, self.m - 1)
            self.surface[sx][sy] = 2

    def isWall(self, var):
        if var[0] < 0 or var[0] > Util.mapLength - 1 or \
                var[1] < 0 or var[1] > Util.mapLength - 1 or self.surface[var[0]][var[1]] == 1:
            return True
        return False

    def image(self, colour=Util.BLUE, background=Util.WHITE, path=None):
        imagine = pygame.Surface((400, 400))
        brick = pygame.Surface((20, 20))
        brick.fill(colour)
        imagine.fill(background)
        vis = pygame.Surface((20, 20))
        vis.fill(Util.GREEN)
        sensor = pygame.Surface((20, 20))
        sensor.fill(Util.RED)
        for i in range(self.n):
            for j in range(self.m):
                if self.surface[i][j] == 1:
                    imagine.blit(brick, (j * 20, i * 20))
                if self.surface[i][j] == 2:
                    imagine.blit(sensor, (j * 20, i * 20))
                if (i, j) == Util.initialPosition:
                    imagine.blit(pygame.image.load("drona.png"), (j * 20, i * 20))
        if path is not None:
            for v in path:
                imagine.blit(vis, (v[0] * 20, v[1] * 20))
            imagine.blit(pygame.image.load("drona.png"), (Util.initialPosition[1] * 20, Util.initialPosition[0] * 20))
        return imagine
