# -*- coding: utf-8 -*-

# imports
import gui
from gui import *
from controller import *
from repository import *
import matplotlib.pyplot as plt


class Ui:
    def __init__(self, contr):
        self.controller = contr
        self.controller.repository.cmap.loadMap('map.txt')
        self._path = []
        self._stats = []
        self.__iterations = []
        self._last_stats = []
        self.__commands = {}

    @staticmethod
    def printMenu():
        print(
            """Map options:
    1. create random map
    2. load a map
    3. save a map
    4. visualise map
EA options:
    5. parameters setup
    6. run the solver
    7. visualise the statistics
    8. view the drone moving on a path
    9. view final statistics
>""", end="")

    def createRandomMap(self):
        self.controller.repository.cmap.randomMap()
        self.controller.repository.randomDrone()
        print("random map was loaded!\n")

    def saveMap(self, mapName='map.txt'):
        self.controller.repository.cmap.saveMap(mapName)
        print("map was saved!\n")

    def loadMap(self, mapName='map.txt'):
        self.controller.repository.cmap.loadMap(mapName)
        print("map was loaded!\n")

    def visualiseMap(self):
        screen = gui.initPyGame()
        img = gui.image(self.controller.repository.cmap)
        screen.blit(img, (0, 0))
        pygame.display.flip()
        gui.closePyGame()

    def parametersSetup(self, file='params.txt'):
        f = open(file, 'r')
        i = 0
        for line in f:
            if i == 0:
                l = line.split(",")
                if not (int(l[0]) == -1 and int(l[1]) == -1):
                    self.controller.setDronePosition(int(l[0]), int(l[1]))
            elif i == 1:
                self.controller.setSteps(int(line))
            elif i == 2:
                self.controller.setNumberOfIterations(int(line))
            elif i == 3:
                self.controller.setPopulationSize(int(line))
            elif i == 4:
                self.controller.setMutationProbability(float(line))
            elif i == 5:
                self.controller.setCrossoverProbability(float(line))
            elif i == 6:
                self.controller.setSeedNb(int(line))
            else:
                break
            i += 1
        f.close()

    def runSolver(self):
        self._path, self._stats, self._last_stats = self.controller.solver()
        print("PATH")
        print(self._path)
        movingDrone(self.controller.repository.cmap, self._path, 0.2)

    def visualiseStatistics(self):
        x = []
        average = []
        for i in range(len(self._last_stats)):
            x.append(i)
            average.append(self._last_stats[i][0])
        plt.plot(x, average)

        plt.show()

    def viewFinalStatistics(self):
        print("Average Fitness: " + str(np.average(self._stats)))
        print("Standard Deviation: " + str(np.std(self._stats)))

    def run(self):
        self.printMenu()
        cmd = input().lower()
        while cmd != "x":
            if cmd == '1':
                self.createRandomMap()
            elif cmd == '2':
                self.loadMap()
            elif cmd == '3':
                self.saveMap()
            elif cmd == '4':
                self.visualiseMap()
            elif cmd == '5':
                print("Filename: ")
                file = input()
                if file != "":
                    self.parametersSetup(file)
                else:
                    self.parametersSetup()
            elif cmd == '6':
                self.runSolver()
            elif cmd == '7':
                self.visualiseStatistics()
            elif cmd == '8':
                movingDrone(self.controller.repository.cmap, self._path, 0.2)
            elif cmd == '9':
                self.viewFinalStatistics()
            else:
                print("Ceva n-ai pus bine  >:|\n")
            self.printMenu()
            cmd = input().lower()


if __name__ == "__main__":
    repo = Repository()
    controller = Controller(repo)
    consoleUi = Ui(controller)

    consoleUi.run()
