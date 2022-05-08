from Boards.MyBoard import MyBoard
from Boards.OpponentBoard import OpponentBoard
from Game.Game import Game
from Player.Human import Human
from UI.ConsoleUi import ConsoleUI

if __name__ == '__main__':
    my_board1, my_board2 = MyBoard(10, 10), MyBoard(10, 10)
    opponent_board1, opponent_board2 = OpponentBoard(10, 10), OpponentBoard(10, 10)
    player1 = Human(my_board1, opponent_board1)
    player2 = Human(my_board2, opponent_board2)
    game = Game(player1, player2, 3)
    UI = ConsoleUI(game)
    UI.run()
