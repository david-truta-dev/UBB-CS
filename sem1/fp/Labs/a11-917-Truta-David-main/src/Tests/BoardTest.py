from unittest.case import TestCase

from Boards.Board import Board, BoardError
from Boards.Cell import Cell
from Boards.Plane import Plane


class BoardTest(TestCase):

    def setUp(self) -> None:
        self.__board = Board(10, 10)

    def test_check_inside_board(self):
        self.assertTrue(self.__board.check_inside_board(Cell(0, 1)))
        self.assertTrue(self.__board.check_inside_board(Cell(9, 9)))
        self.assertRaises(BoardError, self.__board.check_inside_board, Cell(9, 10))

    def test_check_empty_cell(self):
        self.__board.change_cell(Cell(0, 0, 'x'))
        self.assertRaises(BoardError, self.__board._check_empty_cell, Cell(0, 0))
        self.assertTrue(self.__board._check_empty_cell(Cell(3, 3)))
        self.assertTrue(self.__board._check_empty_cell(Cell(9, 4)))

    def test_check_plane_fits_set_plane(self):
        plane = Plane(Cell(0, 2, 'x'), 'up')
        self.__board.set_plane(plane)
        plane = Plane(Cell(3, 5, 'x'), 'down')
        self.__board.set_plane(plane)
        plane = Plane(Cell(4, 9, 'x'), 'right')
        self.__board.set_plane(plane)
        plane = Plane(Cell(7, 0, 'x'), 'left')
        self.__board.set_plane(plane)

        plane = Plane(Cell(4, 4, 'x'), 'up')
        self.assertRaises(BoardError, self.__board.set_plane, plane)

        plane = Plane(Cell(2, 2, 'x'), 'down')
        self.assertRaises(BoardError, self.__board.set_plane, plane)

    def test_clear_board(self):
        self.__board.clear_board()
        board = self.__board.__str__()
        expected_board = "  1 2 3 4 5 6 7 8 9 10\n" \
                         "  ____________________\n" \
                         "A|                   |\n" \
                         "B|                   |\n" \
                         "C|                   |\n" \
                         "D|                   |\n" \
                         "E|                   |\n" \
                         "F|                   |\n" \
                         "G|                   |\n" \
                         "H|                   |\n" \
                         "I|                   |\n" \
                         "J|                   |\n" \
                         " |-------------------|"

        self.assertEqual(board, expected_board)

    def test_str(self):
        plane = Plane(Cell(0, 2, '*'), 'up')
        self.__board.set_plane(plane)
        plane = Plane(Cell(3, 5, '*'), 'down')
        self.__board.set_plane(plane)
        plane = Plane(Cell(4, 9, '*'), 'right')
        self.__board.set_plane(plane)
        plane = Plane(Cell(7, 0, '*'), 'left')
        self.__board.set_plane(plane)

        board = self.__board.__str__()
        expected_board = "  1 2 3 4 5 6 7 8 9 10\n"\
                         "  ____________________\n"\
                         "A|    *   0 0 0      |\n"\
                         "B|0 0 0 0 0 0        |\n"\
                         "C|    0 0 0 0 0 0 0  |\n"\
                         "D|  0 0 0   * 0   0  |\n"\
                         "E|            0 0 0 *|\n"\
                         "F|  0         0   0  |\n"\
                         "G|  0   0         0  |\n"\
                         "H|* 0 0 0            |\n"\
                         "I|  0   0            |\n"\
                         "J|  0                |\n"\
                         " |-------------------|"

        self.assertEqual(board, expected_board)
