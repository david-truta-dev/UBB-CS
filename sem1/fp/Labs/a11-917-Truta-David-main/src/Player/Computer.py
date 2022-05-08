import random

from Boards.Board import BoardError
from Boards.Cell import Cell
from Boards.Plane import Plane


class Computer:
    def __init__(self, myBoard, OpponentBoard, Strategy):
        self._my_board = myBoard
        self._op_board = OpponentBoard
        self._strategy = Strategy
        self._hit_heads = 0
        self._score = 0

    @property
    def strategy(self):
        return self._strategy

    @property
    def score(self):
        return self._score

    @score.setter
    def score(self, value):
        self._score = value

    @property
    def hit_heads(self):
        return self._hit_heads

    @hit_heads.setter
    def hit_heads(self, value):
        self._hit_heads = value

    @property
    def my_board(self):
        return self._my_board

    @property
    def opponent_board(self):
        return self._op_board

    @staticmethod
    def generate_coordinates():
        cell = Cell(random.randint(0, 9), random.randint(0, 9), '*')
        while cell.line == 0 and cell.column == 0 or cell.line == 0 and cell.column == 9 \
                or cell.line == 9 and cell.column == 0 or cell.line == 9 and cell.column == 9:
            cell = Cell(random.randint(0, 9), random.randint(0, 9), '*')
        return cell

    @staticmethod
    def _generate_direction():
        """
        Computes a random direction
        :return: a random direction(string)
        """
        directions = ['up', 'right', 'down', 'left']
        return random.choice(directions)

    def set_planes_computer(self, number_of_planes):
        """
        Sets the planes on the computer's board, they are randomly generated.
        :param number_of_planes: int representing number of planes
        :return: -
        """
        self._my_board.clear_board()
        self._op_board.clear_board()
        i = 1
        while i <= number_of_planes:
            head = self.generate_coordinates()
            plane_direction = self._generate_direction()
            try:
                self.my_board.set_plane(Plane(head, plane_direction))
                i += 1
            except BoardError:
                pass
