from unittest.case import TestCase

from Boards.Cell import Cell
from Boards.MyBoard import MyBoard
from Boards.OpponentBoard import OpponentBoard
from Player.Human import Human


class HumanTest(TestCase):

    def setUp(self) -> None:
        self.__player = Human(MyBoard(10, 10), OpponentBoard(10, 10))

    def test_convert_coordinates(self):
        self.__player.score = 3
        self.__player.hit_heads = 2
        self.assertEqual(self.__player.score, 3)
        self.assertEqual(self.__player.hit_heads, 2)
