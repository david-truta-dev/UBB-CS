import random

from Boards.Board import BoardError
from Boards.Cell import Cell


class NormalStrategy:
    def __init__(self, op_board):
        self._op_board = op_board
        self._queue = []
        self.dirX = [0, 1, 0, -1]
        self.dirY = [-1, 0, 1, 0]

    def valid_cell(self, cell):
        """
        Checks if coordinates of a cell are valid(wasn't given before, it's inside the board
                                                    AND it's not in the corner of the board)
        :param cell: object of type cell, in a board.
        :return: True if the cell is valid(wasn't given before, and it's inside the board),
                 False otherwise
        """
        # Chekcing to see if it is in the corner, if it is, return False
        if cell.line == 0 and cell.column == 0:
            return False
        elif cell.line == 0 and cell.column == 9:
            return False
        elif cell.line == 9 and cell.column == 0:
            return False
        elif cell.line == 9 and cell.column == 9:
            return False
        try:
            self._op_board.check_inside_board(cell)
            self._op_board.check_empty(cell)
            return True
        except BoardError:
            return False

    def set_next_move(self, cell):
        """
        This puts into a queue, all the surrounding cells od 'cell'(given as param.)
        :param cell: an object of type cell (a cell that is part of the body of a plane)
        :return: -
        """
        if self._op_board.check_hit(cell) is True:
            lst = [0, 1, 2, 3]
            for _ in range(4):
                r = random.choice(lst)
                lst.remove(r)
                new_cell = Cell(cell.line + self.dirX[r], cell.column + self.dirY[r])
                if self.valid_cell(new_cell) is True and (new_cell not in self._queue):
                    self._queue.insert(0, new_cell)
        elif self._op_board.check_head is True:
            self._queue.clear()

    def get_next_move(self):
        """
        Returns None, or a Cell with the coordinates of a logical move.
        :return: None if there are no moves logical moves left(queue is empty)
                The last element introduced in queue.
        """
        if len(self._queue) == 0:
            return None
        else:
            return self._queue.pop(0)
