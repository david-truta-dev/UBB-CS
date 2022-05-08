import pygame, sys
from pygame.locals import *

from OpenGL.GL import *
from OpenGL.GLU import *

######
import random

verticies = (
    (1, -1, -1),
    (1, 1, -1),
    (-1, 1, -1),
    (-1, -1, -1),
    (1, -1, 1),
    (1, 1, 1),
    (-1, -1, 1),
    (-1, 1, 1)
)

edges = (
    (0, 1),
    (0, 3),
    (0, 4),
    (2, 1),
    (2, 3),
    (2, 7),
    (6, 3),
    (6, 4),
    (6, 7),
    (5, 1),
    (5, 4),
    (5, 7)
)

surfaces = (
    (0, 1, 2, 3),
    (3, 2, 7, 6),
    (6, 7, 5, 4),
    (4, 5, 1, 0),
    (1, 5, 7, 2),
    (4, 0, 3, 6)
)

colors = (
    (1, 0, 0),
    (0, 1, 0),
    (0, 0, 1),
    (0, 1, 0),
    (1, 1, 1),
    (0, 1, 1),
    (1, 0, 0),
    (0, 1, 0),
    (0, 0, 1),
    (1, 0, 0),
    (1, 1, 1),
    (0, 1, 1),
)


def Cube():
    glBegin(GL_QUADS)

    for surface in surfaces:
        x = 0

        for vertex in surface:
            x += 1
            glColor3fv(colors[x])
            glVertex3fv(verticies[vertex])

    glEnd()

    glBegin(GL_LINES)
    for edge in edges:
        for vertex in edge:
            glVertex3fv(verticies[vertex])
    glEnd()


def main():
    pygame.init()
    display = (800, 600)
    pygame.display.set_mode(display, DOUBLEBUF | OPENGL)

    gluPerspective(45, (display[0] / display[1]), 0.1, 50.0)

    # start further back
    glTranslatef(random.randrange(-5, 5), 0, -30)

    # no more rotate
    # glRotatef(25, 2, 1, 0)

    object_passed = False

    ind = False

    while not object_passed:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                ind = True
                pygame.quit()
                break

            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_LEFT:
                    glTranslatef(-0.5, 0, 0)
                if event.key == pygame.K_RIGHT:
                    glTranslatef(0.5, 0, 0)

                if event.key == pygame.K_UP:
                    glTranslatef(0, 1, 0)
                if event.key == pygame.K_DOWN:
                    glTranslatef(0, -1, 0)
            '''
            if event.type == pygame.MOUSEBUTTONDOWN:
                if event.button == 4:
                    glTranslatef(0,0,1.0)

                if event.button == 5:
                    glTranslatef(0,0,-1.0)
            '''
        if ind:
            break

        x = glGetDoublev(GL_MODELVIEW_MATRIX)  # , modelviewMatrix)

        camera_x = x[3][0]
        camera_y = x[3][1]
        camera_z = x[3][2]

        # print(camera_x,camera_y,camera_z)

        # slowly move:
        glTranslatef(0, 0, 0.5)

        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        Cube()
        pygame.display.flip()

        if camera_z <= 0:
            object_passed = True
        pygame.time.delay(250)
    pygame.quit()
    sys.exit()


main()
