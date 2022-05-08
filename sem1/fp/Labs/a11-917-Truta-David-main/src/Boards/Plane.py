from dataclasses import dataclass

from Boards.Cell import Cell


@dataclass
class Plane:
    head: Cell
    facing: str

    def rotate(self):
        """
        Rotates the facing of the plane to the right.
        :return: -
        """
        if self.facing == 'up':
            self.facing = 'right'
        elif self.facing == 'right':
            self.facing = 'down'
        elif self.facing == 'down':
            self.facing = 'left'
        elif self.facing == 'left':
            self.facing = 'up'

    def body(self):
        """
        Computes a list of cells, representing the plane's body, depending on the way it is facing and
        the coordinates of the head.
        :return: a list of cells, representing the plane's body
        """
        facing_up = [(1, 0), (1, -1), (1, -2), (1, 1), (1, 2), (2, 0), (3, 0), (3, -1), (3, 1)]
        body_element = '0'
        res = []
        if self.facing == 'up':
            for tup in facing_up:
                res.append(Cell(self.head.line + tup[0], self.head.column + tup[1], body_element))
        elif self.facing == 'right':
            for tup in facing_up:
                res.append(Cell(self.head.line + tup[1], self.head.column - tup[0], body_element))
        elif self.facing == 'down':
            for tup in facing_up:
                res.append(Cell(self.head.line - tup[0], self.head.column - tup[1], body_element))
        elif self.facing == 'left':
            for tup in facing_up:
                res.append(Cell(self.head.line - tup[1], self.head.column + tup[0], body_element))
        return res

