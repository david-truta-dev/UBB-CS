from unittest import TestCase

from AiStrategies.NormalStrategy import NormalStrategy
from Boards.MyBoard import MyBoard
from Boards.OpponentBoard import OpponentBoard
from Player.Computer import Computer


class ComputerTest(TestCase):

    def setUp(self) -> None:
        op_board = OpponentBoard(10, 10)
        self.__player = Computer(MyBoard(10, 10), op_board, NormalStrategy(op_board))

    def test_generate_coordinates(self):
        for _ in range(100):
            coord = self.__player.generate_coordinates()
            self.assertTrue(0 <= coord.line <= 9 and 0 <= coord.column <= 9)

    def test_generate_direction(self):
        directions = ['up', 'right', 'down', 'left']
        for _ in range(20):
            direction = self.__player._generate_direction()
            self.assertTrue(direction in directions)

    def test_set_planes_computer(self):
        self.__player.set_planes_computer(3)
        self.assertEqual(self.__player.my_board.__str__().count('*'), 3)
        self.assertEqual(self.__player.my_board.__str__().count('0'), 28)
