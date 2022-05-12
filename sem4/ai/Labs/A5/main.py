# -*- coding: utf-8 -*-

import math
import sys, pygame
from pygame.locals import *
from pygame.constants import *
from OpenGL.GL import *
from OpenGL.GLU import *
from math import sin, cos, pi, trunc

# IMPORT OBJECT LOADER
from objloader import *
from solver import solver


def loadTexture():
    textureSurface = pygame.image.load('texture_table.png')
    textureData = pygame.image.tostring(textureSurface, "RGBA", 1)
    width = textureSurface.get_width()
    height = textureSurface.get_height()

    glEnable(GL_TEXTURE_2D)
    texid = glGenTextures(1)

    glBindTexture(GL_TEXTURE_2D, texid)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height,
                 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData)

    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)

    return texid


class Corp:
    def __init__(self, file):
        self.file = file
        self.body = OBJ(self.file, swapyz=True)

    def draw(self):
        return self.body.draw()

    def scale(self, size=1.0):
        self.body.scale(size)

    def translate(self, cx=0, cy=0, cz=0):
        self.body.translate(cx, cy, cz)

    def moveInOrigin(self):
        self.body.moveInOrigin()


class Mecanism():
    def __init__(self):
        """ the ansamble is formed from vehicol and pendulum """

        self.roata = Corp("roata.obj")
        self.masina = Corp("masina.obj")
        self.pendul = Corp("pendul.obj")

        self.scaleTime = 1 / (10)

        self.xMax = 500
        self.tMax = 0.35

        # fizica obiectului
        self.M = 1  # mass of the cart in kg
        self.m = 0.1  # mass of the pendulum in kg
        self.b = 0.8  # coeficient of friction for the cart
        self.bp = 0.01  # coeficient of friction for the pendulum
        self.l = 1  # length to pendulum center of the mass
        self.I = 0.006  # mass momentum of inertia for the pendulum
        self.F = 0  # force applied to the cart
        self.x = 0  # cart position coordinate
        self.theta = 0.22 * pi  # pendulum angle from vertical (down) in radians
        self.dx = 0  # first derivative of x is zero (no speed)
        self.d2x = 0  # second derivative of x is zero (no acceletation)
        self.dtheta = 0  # no variation for theta
        self.d2theta = 0  # no acceleration for theta
        self.g = 9.8  # the gravitational acceleration

        self.precision = 2

        self.t = self.theta / pi * 180

    def toRadian(self, angle):
        return angle / 180.0 * math.pi

    def toDegrees(self, angle):

        return int(angle / pi * 180)

    def truncate(self, number, digits) -> float:
        stepper = 10.0 ** digits
        return trunc(stepper * number) / stepper

    def dynamics(self, F=0):

        # calculam acceleratia unghiului pendulului in raport cu fortele aplicate
        self.d2theta = self.g * sin(self.theta)
        self.d2theta += -(self.m * self.l * (self.dtheta ** 2) * cos(self.theta) * sin(self.theta)) / (self.M + self.m)
        self.d2theta += -cos(self.theta) * F / (self.M + self.m)
        self.d2theta = self.d2theta / (self.l * (4 / 3 - (self.m * (cos(self.theta) ** 2)) / (self.M + self.m)))

        self.d2theta = self.truncate(self.d2theta, self.precision)

        # calculam unghiul theta
        self.t = self.truncate(self.theta / pi * 180, self.precision)

        self.t = self.t + self.dtheta * self.scaleTime + 0.5 * self.d2theta * (self.scaleTime ** 2)

        # calculam viteza unghiulara
        self.dtheta = self.dtheta + self.d2theta * self.scaleTime

        self.dtheta = self.truncate(self.dtheta, self.precision)

        # unghiul theta in radiani
        self.theta = self.t / 180 * pi

        # impunem restrictiile legate de unghi si viteza unghiulara
        if self.theta > self.tMax * pi:
            self.theta = self.tMax * pi
            if self.dtheta > 0:
                self.dtheta = 0
        if self.theta < - self.tMax * pi:
            self.theta = -self.tMax * pi
            if self.dtheta < 0:
                self.dtheta = 0

        if self.dtheta > 8:
            self.dtheta = 8
        if self.dtheta < -8:
            self.dtheta = -8

        # calculam acceleratia vehicolului in raport cu forta F aplicata
        self.d2x = F + self.m * self.l * (self.dtheta ** 2) * sin(self.theta)
        self.d2x += self.m * self.l * self.d2theta * cos(self.theta)
        self.d2x += -self.b * self.dx
        self.d2x = self.d2x / (self.M + self.m)

        self.d2x = self.truncate(self.d2x, self.precision)

        # calculam pozitia noua a lui x
        newX = self.x + self.dx * self.scaleTime + 0.5 * self.d2x * (self.scaleTime ** 2)

        self.truncate(newX, self.precision)
        # calculam viteza vehicolului
        self.dx = self.dx + self.d2x * self.scaleTime
        self.truncate(self.dx, self.precision)

        # verificam sa ramanem in domeniu [-1m, 1m]
        # la capete oprim fortat vehicolul
        if newX > self.xMax:
            newX = self.xMax
            if self.dx > 0:
                self.dx = 0
            if self.d2x > 0:
                self.d2x = 0
        if newX < -self.xMax:
            newX = -self.xMax
            if self.dx < 0:
                self.dx = 0
            if self.d2x < 0:
                self.d2x = 0

        self.x = newX

        return int(self.theta / pi * 180), self.dtheta

    def movePendul(self, theta):

        # rotirea pendulului cu unghiul theta

        glPushMatrix()
        glTranslate(3, 4, 0)
        glRotate(theta, 0, 0, 1)
        glTranslate(-3, -4, 0)
        self.pendul.draw()
        glPopMatrix()

    def moveRoata(self, alfa):

        # rotirea rotii cu unghiul alfa
        glPushMatrix()
        glTranslate(10.86, 10.86, 0)
        glRotate(alfa, 0, 0, 1)
        glTranslate(-10.86, -10.86, 0)
        self.roata.draw()
        glPopMatrix()

    def draw(self):
        self.drawVehicol(-self.t, -self.x * 5, self.x)

    def drawVehicol(self, theta, alfa, x):

        glPushMatrix()
        glTranslate(x, 0, 2)

        # roata 1
        glPushMatrix()
        glTranslate(0.86, 0, -7)
        self.moveRoata(alfa)
        glPopMatrix()

        # roata 2
        glPushMatrix()
        glTranslate(0.86, 0, -24)
        self.moveRoata(alfa)
        glPopMatrix()

        # roata 3
        glPushMatrix()
        glTranslate(78.28, 0, -24)
        self.moveRoata(alfa)
        glPopMatrix()

        # roata 4
        glPushMatrix()
        glTranslate(78.28, 0, -7)
        self.moveRoata(alfa)
        glPopMatrix()

        # corpul masinii
        glPushMatrix()
        glTranslate(0, 4.86, -20)
        self.masina.draw()

        # pendul
        glPushMatrix()
        glTranslate(47, 3.5, 22)
        self.movePendul(theta)
        glPopMatrix()
        glPopMatrix()

        glPopMatrix()


class Table():
    def __init__(self):
        self.verticies = [[-1.0, 0.0, 0.0],
                          [-1.0, 0.0, -1.0],
                          [1.0, 0.0, -1.0],
                          [1.0, 0.0, 0.0]]
        self.edges = [[0, 1], [0, 3], [1, 2], [2, 3]]
        self.faces = [[0, 1, 2, 3]]
        self.colors = [[1, 0, 0],
                       [0, 1, 0],
                       [0, 0, 1],
                       [0, 1, 0],
                       [1, 1, 1],
                       [0, 1, 1],
                       [1, 0, 0],
                       [0, 1, 0],
                       [0, 0, 1]]
        self.texvert = [[0, 0], [0, 1], [1, 1], [1, 0]]

    def draw(self, size=1.0):
        self.textureID = loadTexture()
        aux = [[x * size for x in lines] for lines in self.verticies]
        auxColor = [0.5, 0.5, 0.5]
        glBegin(GL_QUADS)

        for surface in self.faces:
            x = 0

            for vertex in surface:
                x += 1
                # glColor3fv(auxColor)#self.colors[x])
                glTexCoord2f(self.texvert[vertex][0], self.texvert[vertex][1])
                glVertex3fv(aux[vertex])

        glEnd()

        glBegin(GL_LINES)
        for edge in self.edges:
            for vertex in edge:
                glVertex3fv(aux[vertex])
        glEnd()


def test():
    pygame.init()
    pygame.display.set_caption("reversed pendulum")
    viewport = (1800, 600)
    hx = viewport[0] / 2
    hy = viewport[1] / 2
    screen = pygame.display.set_mode(viewport, OPENGL | DOUBLEBUF)

    mat_specular = [1.0, 1.0, 1.0, 1.0]
    mat_shininess = [50.0]
    light_position = [0.0, 1.0, 1.0, 0.0]
    glClearColor(0.0, 0.0, 0.0, 0.0)
    glShadeModel(GL_SMOOTH)

    glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
    glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);
    glLightfv(GL_LIGHT0, GL_AMBIENT, (0.6, 0.6, 0.6, 1.0))
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);

    glLightf(GL_LIGHT1, GL_SPOT_CUTOFF, 45.0);

    spot_direction = [-1.0, -1.0, 0.0]
    glLightfv(GL_LIGHT1, GL_SPOT_DIRECTION, spot_direction)
    position = [1.0, 1.0, 1.0, 1.0]
    glLightfv(GL_LIGHT1, GL_POSITION, position)

    glEnable(GL_LIGHTING)
    glEnable(GL_LIGHT0)
    # glEnable(GL_LIGHT1)
    glEnable(GL_DEPTH_TEST)

    revPend = Mecanism()

    table = Table()

    clock = pygame.time.Clock()

    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    width, height = viewport
    gluPerspective(90.0, width / float(height), 1, 400.0)
    glEnable(GL_DEPTH_TEST)
    glMatrixMode(GL_MODELVIEW)

    rx, ry = (0, 0)
    tx, ty = (0, 0)
    zpos = 200
    rotate = move = False

    alfa = theta = 0
    x = 0
    dx = 1
    step = 5

    appliedForce = 0

    while 1:
        # clock.tick(20)
        for e in pygame.event.get():
            if e.type == QUIT:
                # print(revPend.w, revPend.W)
                pygame.quit()
                sys.exit()
                # glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
            elif e.type == KEYDOWN and e.key == K_ESCAPE:
                pygame.quit()
                sys.exit()

            elif e.type == KEYDOWN:
                pressed_keys = pygame.key.get_pressed()
                if pressed_keys[K_LEFT]:
                    oldT = revPend.theta
                    revPend.theta += -15
                    if revPend.theta < -revPend.tMax:
                        revPend.theta = -revPend.tMax
                        revPend.dtheta = oldT - revPend.theta

                if pressed_keys[K_RIGHT]:
                    oldT = revPend.theta
                    revPend.theta += 15
                    if revPend.theta > revPend.tMax:
                        revPend.theta = revPend.tMax
                        revPend.dtheta = oldT - revPend.theta

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        glLoadIdentity()

        # RENDER OBJECT
        glTranslate(tx / 20. - 50, ty / 20. - 50, - zpos)
        glRotate(ry, 1, 0, 0)
        glRotate(rx, 0, 1, 0)

        # se deseneaza masa
        table.draw(2000)

        # se aplica modelul fizic
        t, w = revPend.dynamics(appliedForce)

        # se calculeaza raspunsul
        newForce = solver(t, w)
        if newForce != None:
            appliedForce = newForce
        print(t, w, appliedForce)
        # se deseneaza pendulul
        revPend.draw()

        pygame.display.flip()

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
    pygame.quit()


test()
