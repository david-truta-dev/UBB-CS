import pygame

import gui


class Ui:
    def __init__(self, contr):
        self.controller = contr
        self.controller.repository.map.loadMap('map.txt')
        self.loadParameters()

    @staticmethod
    def printMenu():
        print(
            """Setup options:
    1. load a map
    2. load parameters
    3. visualise map
A4 requests:
    4. show for each sensor the number of squares from each value from 0 to 5
    5. show the min distance between each pair of sensors && shortest path between sensors with ACO && determine
     using any method the quantity of energy that is left there
>""", end="")

    def loadMap(self, mapName='map.txt'):
        self.controller.repository.map.loadMap(mapName)
        print("map was loaded!\n")

    def visualiseMap(self):
        screen = gui.initPyGame()
        drone = pygame.image.load("drona.png")
        sensor = pygame.image.load("sensor.png")
        img = gui.image(self.controller.repository.map)
        screen.blit(img, (0, 0))
        screen.blit(drone, (self.controller.getDronePosition()[0] * 20, self.controller.getDronePosition()[1] * 20))
        for s in self.controller.getSensors():
            screen.blit(sensor, (s[0] * 20, s[1] * 20))
            pass
        pygame.display.flip()
        gui.closePyGame()

    def loadParameters(self, file='params.txt'):
        f = open(file, 'r')
        i = 0
        sensors = []
        for line in f:
            if i == 0:
                l = line.split(",")
                if not (int(l[0]) == -1 and int(l[1]) == -1):
                    self.controller.setDronePosition(int(l[0]), int(l[1]))
            elif i == 1:
                self.controller.setEnergy(int(line))
            elif i == 2:
                self.controller.setNumberOfSensors(int(line))
            elif 2 < i <= 2+self.controller.getNumberOfSensors():
                l = line.split(",")
                if not (int(l[0]) == -1 and int(l[1]) == -1):
                    sensors.append((int(l[0]), int(l[1])))
            else:
                break
            i += 1
        f.close()
        self.controller.setSensors(sensors)
        print("parameters were loaded!\n")

    def task1(self):
        print(self.controller.getSensorDetection())
        self.visualiseMap()

    def task234(self):
        minDistance, shortestPath, sensorsEnergy, path = self.controller.getShortestPathBetweenSensors()
        print("Min Distance between sensors:", minDistance)
        print("Shortest path between sensors:", shortestPath)
        print("Energy left at each sensor:", sensorsEnergy)
        gui.movingDrone(self.controller.repository.map, path, 0.2)

    def run(self):
        self.printMenu()
        cmd = input().lower()
        while cmd != "x":
            if cmd == '1':
                self.loadMap()
            elif cmd == '2':
                print("Filename: ")
                file = input()
                if file != "":
                    self.loadParameters(file)
                else:
                    self.loadParameters()
            elif cmd == '3':
                self.visualiseMap()
            elif cmd == '4':
                self.task1()
            elif cmd == '5':
                self.task234()
            else:
                print("Ceva n-ai pus bine >:|\n")
            self.printMenu()
            cmd = input().lower()
