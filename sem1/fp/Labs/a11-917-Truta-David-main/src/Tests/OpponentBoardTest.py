from unittest import TestCase

from Boards.Cell import Cell
from Boards.OpponentBoard import OpponentBoard


class OpponentBoardTest(TestCase):

    def setUp(self) -> None:
        self.__board = OpponentBoard(10, 10)

    def test_check_head(self):
        self.__board.change_cell(Cell(0, 0, 'x'))
        self.__board.change_cell(Cell(2, 3, '*'))
        self.__board.change_cell(Cell(4, 7, '0'))
        self.__board.change_cell(Cell(7, 2, '#'))
        self.assertTrue(self.__board.check_head(Cell(7, 2)))
        self.assertFalse(self.__board.check_head(Cell(2, 3)))
        self.assertFalse(self.__board.check_head(Cell(0, 0)))
        self.assertFalse(self.__board.check_head(Cell(4, 7)))
        self.assertFalse(self.__board.check_head(Cell(3, 3)))

    def test_check_hit(self):
        self.__board.change_cell(Cell(0, 0, 'x'))
        self.__board.change_cell(Cell(2, 3, '*'))
        self.__board.change_cell(Cell(4, 7, '0'))
        self.assertTrue(self.__board.check_hit(Cell(0, 0)))
        self.assertFalse(self.__board.check_hit(Cell(2, 3)))
        self.assertFalse(self.__board.check_hit(Cell(3, 3)))
        self.assertFalse(self.__board.check_hit(Cell(2, 9)))

