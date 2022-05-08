from Boards.Board import BoardError
from Boards.Plane import Plane


class Human:
    def __init__(self, myBoard, OpponentBoard):
        self._my_board = myBoard
        self._op_board = OpponentBoard
        self._hit_heads = 0
        self._score = 0
        self._set_planes = 0

    @property
    def set_planes(self):
        return self._set_planes

    @set_planes.setter
    def set_planes(self, value):
        self._set_planes = value

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

    def set_planes_human(self, input, number_of_planes):
        """
        Reads coordinates and direction, and sets planes on player's board.
        :param number_of_planes:
        :param input:
        :return:
        """
        coord = input[0]
        plane_direction = input[1]
        try:
            self.my_board.set_plane(Plane(coord, plane_direction))
            self.set_planes += 1
        except BoardError as be:
            return be
        if self.set_planes == number_of_planes:
            return True
        return False
