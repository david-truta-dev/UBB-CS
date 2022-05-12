from Controller import Controller

from utils import Util
from gui import moving_drone


if __name__ == '__main__':
    battery = Util.batteryCapacity
    c = Controller()
    ant = c.computeACO()
    print(" done ")
    moving_drone(c.map, ant[0].path)
