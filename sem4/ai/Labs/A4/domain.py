from random import *
import numpy as np
import pickle


class Ant:
    def __init__(self, n, m, map):
        # constructor pentru clasa ant
        self.size = n * m
        self.path = [randint(0, self.size - 1)]
        """
        drumul construit de furnica initializat aleator pe prima pozitie
        drumul este o permutare de self.size elemente, fiecare numar
        reprezentand o casuta a tablei de sah:
        pt n=4, m=6
        0  este casuta 0, 0
        1  este casuta 0, 1
        ...
        5  este casuta 0, 5
        6  este casuta 1, 0
        ...
        23 este casuta 3, 5 (ultima din cele 24 de casute)
        """
        self.n = n
        self.m = m
        self.map = map

    @staticmethod
    def distance(x, y, xfinal, yfinal):
        return abs(x - xfinal) + abs(y - yfinal)

    def nextMoves(self, a):
        # returneaza o lista de posibile mutari corecte de la pozitia a
        new = []
        x = int(a / self.m)
        y = a - int(a / self.m) * self.m
        variatiaX = [0, 0, -1, 1]
        variatiaY = [-1, 1, 0, 0]
        for i in range(4):
            nextX = x + variatiaX[i]
            nextY = y + variatiaY[i]
            if (nextX >= 0) and (nextX < self.n) and (nextY >= 0) and (nextY < self.m) and self.map.surface[y][x] == 0:
                b = nextX * self.m + nextY
                if b not in self.path:
                    new.append(b)
        return new.copy()

    def distMove(self, a):
        # returneaza o distanta empirica data de numarul de posibile mutari corecte
        # dupa ce se adauga pasul a in path
        dummy = Ant(self.n, self.m, self.map)
        dummy.path = self.path.copy()
        dummy.path.append(a)
        return 5 - len(dummy.nextMoves(a))

    def addMove(self, q0, trace, alpha, beta):
        # adauga o noua pozitie in solutia furnicii daca este posibil
        p = [0 for i in range(self.size)]
        # pozitiile ce nu sunt valide vor fi marcate cu zero
        nextSteps = self.nextMoves(self.path[len(self.path) - 1]).copy()
        # determina urmatoarele pozitii valide in nextSteps
        # daca nu avem astfel de pozitii iesim
        if len(nextSteps) == 0:
            return False
        # punem pe pozitiile valide valoarea distantei empirice
        for i in nextSteps:
            p[i] = self.distMove(i)
        # calculam produsul trace^alpha si vizibilitate^beta
        p = [(p[i] ** beta) * (trace[self.path[-1]][i] ** alpha) for i in range(len(p))]
        if random() < q0:
            # adaugam cea mai buna dintre mutarile posibile
            p = [[i, p[i]] for i in range(len(p))]
            p = max(p, key=lambda a: a[1])
            self.path.append(p[0])
        else:
            # adaugam cu o probabilitate un drum posibil (ruleta)
            s = sum(p)
            if s == 0:
                return choice(nextSteps)
            p = [p[i] / s for i in range(len(p))]
            p = [sum(p[0:i + 1]) for i in range(len(p))]
            r = random()
            i = 0
            while r > p[i]:
                i = i + 1
            self.path.append(i)
        return True

    def fitness(self):
        # un drum e cu atat mai bun cu cat este mai scurt
        # problema de minimizare, drumul maxim e n * m
        return len(self.path)


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
