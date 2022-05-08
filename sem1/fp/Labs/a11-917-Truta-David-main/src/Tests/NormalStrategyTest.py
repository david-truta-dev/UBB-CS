import unittest

from AiStrategies.NormalStrategy import NormalStrategy
from Boards.MyBoard import MyBoard
from Boards.OpponentBoard import OpponentBoard
from Game.Game import Game
from Player.Computer import Computer


class NormalStrategyTest(unittest.TestCase):
    def setUp(self) -> None:
        op_board = OpponentBoard(10, 10)
        my_board = MyBoard(10, 10)
        self.comp = Computer(my_board, op_board, NormalStrategy(op_board))

    def test_strategy(self):
        avg = 0
        mn = 100
        mx = 0
        for i in range(2000):
            self.comp.my_board.clear_board()
            self.comp.opponent_board.clear_board()
            self.comp.set_planes_computer(3)
            tries = 0
            while self.comp.my_board.__str__().count('#') < 3:

                random_move = self.comp.generate_coordinates()
                while self.comp.my_board.check_good_coordinates(random_move) is False:
                    random_move = self.comp.generate_coordinates()

                # Checking if there are any logical moves:
                logical_move = self.comp.strategy.get_next_move()
                if logical_move is None:
                    # if HERE --> There are no logical moves
                    # so we choose the random one
                    Game.set_cells(random_move, self.comp, self.comp)
                    self.comp.strategy.set_next_move(random_move)
                else:
                    Game.set_cells(logical_move, self.comp, self.comp)
                    self.comp.strategy.set_next_move(logical_move)

                tries += 1
                # print(self.comp.my_board, '\n-----------------------------------------------------------')
            avg += tries
            if tries > mx:
                mx = tries
            if tries < mn:
                mn = tries
            # print('TRY nr', i, ':', tries)

        avg /= 2000
        print('Average:', avg)
        print('Max:', mx)
        print('Min:', mn)
        # Average of the number of moves it takes the AI to win the game should be <= 55,
        # in order to pass this test
        self.assertTrue(avg <= 55)
