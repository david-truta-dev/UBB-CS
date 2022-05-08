import math
import time
from random import randint
import pygame

from Domain.Node import Node


class Service:
    def __init__(self, d, m):
        self.drone = d
        self.map = m
        self.start = None
        self.finish = None
        self.directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]

    @staticmethod
    def displayWithPath(image, path):
        mark = pygame.Surface((20, 20))
        GREEN = (0, 255, 0)
        mark.fill(GREEN)
        for move in path:
            image.blit(mark, (move[1] * 20, move[0] * 20))
        return image

    def randomEmptySquare(self):
        x = randint(0, 19)
        y = randint(0, 19)
        # so we don't spawn it on a block
        while self.map.surface[x][y] != 0:
            x = randint(0, 19)
            y = randint(0, 19)
        return [x, y]

    def distance(self, coord):
        d1, d2 = self.finish[0] - coord[0], self.finish[1] - coord[1]
        return float(math.sqrt((d1 * d1) + (d2 * d2)))

    @staticmethod
    def getSmallestNode(lst):
        res = lst[0]
        for node in lst:
            if node.f < res.f:
                res = node
        return res

    def valid(self, x, y):
        if x >= self.map.n or y >= self.map.m or x < 0 or y < 0 or self.map.surface[x][y] != 0:
            return False
        return True

    def searchGreedy(self):
        path, goto, visited = [], [self.start], [[False for _ in range(self.map.n)] for _ in range(self.map.m)]
        x, y = self.start
        while [x, y] != self.finish:
            visited[x][y] = True
            for i in range(4):
                newX, newY = x + self.directions[i][0], y + self.directions[i][1]
                if self.valid(newX, newY) and visited[newX][newY] is False and [newX, newY] not in goto:
                    goto.append([x, y])
                    goto.append([newX, newY])

            goto.sort(key=self.distance, reverse=True)

            if len(goto) == 0:
                return None

            x, y = goto.pop()
            path.append([x, y])

        return path

    def searchAStar(self):
        startNode = Node(None, self.start)
        startNode.f = startNode.g = startNode.h = 0
        endNode = Node(None, self.finish)
        endNode.f = endNode.g = endNode.h = 0

        openList = []
        closedList = []
        # add startNode to openList
        openList.append(startNode)

        while len(openList) > 0:
            # Get current node:
            currentNode, currentIndex = openList[0], 0
            for index, item in enumerate(openList):
                if item.f < currentNode.f:
                    currentNode = item
                    currentIndex = index

            openList.pop(currentIndex)
            closedList.append(currentNode)

            # Found path
            if currentNode == endNode:
                path = []
                crr = currentNode
                while crr is not None:
                    path.append(crr.position)
                    crr = crr.parent
                return path[::-1]

            # Generate children
            children = []
            for newPosition in self.directions:
                # Get node position
                nodePosition = [currentNode.position[0] + newPosition[0], currentNode.position[1] + newPosition[1]]

                if self.valid(nodePosition[0], nodePosition[1]) is False:
                    continue

                newNode = Node(currentNode, nodePosition)

                children.append(newNode)

            # Loop through the children
            for child in children:
                for closedChild in closedList:
                    if child == closedChild:
                        continue

                child.g = currentNode.g + 1
                # Heuristic:
                child.h = 2*(abs(self.finish[0] - child.position[0]) + abs(self.finish[1] - child.position[1]))
                child.f = child.g + child.h

                # Child already in open List
                for openNode in openList:
                    if child == openNode and child.g > openNode.g:
                        continue

                # Add the child to the open list
                openList.append(child)

    def run(self):
        self.map.loadMap("test1.map")

        # initialize the pygame module
        pygame.init()
        # load and set the logo
        logo = pygame.image.load("logo32x32.png")
        pygame.display.set_icon(logo)
        pygame.display.set_caption("Path in simple environment")

        # Setting the starting and finish point of path:
        self.start = self.randomEmptySquare()
        self.finish = [19, 19]

        # create a surface on screen that has the size of 400 x 480
        screen = pygame.display.set_mode((400, 400))
        screen.fill((255, 255, 255))

        # define a variable to control the main loop
        running = True
        while running:
            print(self.start, self.finish)
            for event in pygame.event.get():
                # only do something if the event is of type QUIT
                if event.type == pygame.QUIT:
                    # change the value to False, to exit the main loop
                    running = False
            screen.blit(self.drone.mapWithDrone(self.map.image()), (0, 0))
            pygame.display.flip()

            # Stopwatch:
            startTime = time.time()
            # Calling Greedy search:
            # path = self.searchGreedy()
            path = self.searchAStar()
            finishTime = time.time() - startTime
            print(finishTime)

            # If there is a path, show it on the screen
            if path is not None:
                screen.blit(Service.displayWithPath(self.map.image(), path), (0, 0))
                pygame.display.flip()
                time.sleep(3)

            self.start = self.randomEmptySquare()

        pygame.display.flip()
        pygame.quit()
