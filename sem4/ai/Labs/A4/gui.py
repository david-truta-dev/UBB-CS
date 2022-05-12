from utils import *
import pygame
from copy import deepcopy


def init_pygame(dimension):
    pygame.init()
    logo = pygame.image.load("logo32x32.png")
    pygame.display.set_icon(logo)
    pygame.display.set_caption("A4 ACO")
    screen = pygame.display.set_mode(dimension)
    screen.fill(Util.WHITE)
    return screen


def close_pygame():
    running = True
    while running:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
    pygame.quit()


def moving_drone(current_map, path, speed=0.5):
    screen = init_pygame((current_map.m * Util.mapLength, current_map.n * Util.mapLength))
    drona = pygame.transform.scale(pygame.image.load("drona.png"), (Util.mapLength, Util.mapLength))
    brick = pygame.Surface((Util.mapLength, Util.mapLength))
    brick.fill(Util.GREEN)
    brick.set_alpha(48)
    sighted_cell = pygame.Surface((Util.mapLength, Util.mapLength))
    sighted_cell.fill(Util.RED)
    sighted_cell.set_alpha(128)
    sensor = pygame.transform.scale(pygame.image.load("sensor.png"), (Util.mapLength, Util.mapLength))
    running = True
    for cell_i in range(len(path)):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
        if not running:
            break
        screen.blit(image(current_map), (0, 0))
        for j in range(cell_i+1):
            screen.blit(brick, (path[j][1] * 20, path[j][0] * 20))
        for cell in path[:cell_i+1]:
            if current_map.surface[cell[0]][cell[1]] == 2:
                i = cell[0]
                j = cell[1]
                neighbours = [[i, j], [i, j], [i, j], [i, j]]
                for _ in range(cell[2]):
                    for direction_index in range(len(Util.v)):
                        new_neighbour = deepcopy(neighbours[direction_index])
                        new_neighbour[0] += Util.v[direction_index][0]
                        new_neighbour[1] += Util.v[direction_index][1]
                        if 0 <= new_neighbour[0] < current_map.n and 0 <= new_neighbour[1] < current_map.m:
                            if current_map.surface[new_neighbour[0]][new_neighbour[1]] != 1:
                                neighbours[direction_index] = new_neighbour
                                screen.blit(sighted_cell, (new_neighbour[1] * Util.mapLength, new_neighbour[0] * Util.mapLength))
        for i in range(current_map.n):
            for j in range(current_map.m):
                if current_map.surface[i][j] == 2:
                    screen.blit(sensor, (j * Util.mapLength, i * Util.mapLength))
        screen.blit(drona, (path[cell_i][1] * Util.mapLength, path[cell_i][0] * Util.mapLength))
        pygame.display.flip()
        pygame.time.wait(int(speed * 500))
    close_pygame()


def image(current_map, colour=Util.BLUE, background=Util.WHITE):
    imagine = pygame.Surface((current_map.m * Util.mapLength, current_map.n * Util.mapLength))
    brick = pygame.Surface((Util.mapLength, Util.mapLength))
    brick.fill(colour)
    imagine.fill(background)
    for i in range(current_map.n):
        for j in range(current_map.m):
            if current_map.surface[i][j] == 1:
                imagine.blit(brick, (j * Util.mapLength, i * Util.mapLength))
    return imagine
