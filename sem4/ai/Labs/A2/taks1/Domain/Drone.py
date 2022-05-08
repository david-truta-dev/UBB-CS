import math

import pygame


class Drone:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def mapWithDrone(self, mapImage):
        drona = pygame.image.load("drona.png")
        mapImage.blit(drona, (self.y * 20, self.x * 20))

        return mapImage
