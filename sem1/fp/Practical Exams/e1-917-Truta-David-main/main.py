import configparser

from domain.board import Board
from game.game import Game
from ui.ui import Ui


def load_board():
    settings = configparser.RawConfigParser()
    settings.read('settings.ini')
    DIM = settings.get('SETTINGS', 'DIM')
    apple_count = settings.get('SETTINGS', 'apple_count')
    return Board(int(DIM), int(apple_count))


if __name__ == '__main__':
    board = load_board()
    game = Game(board)
    ui = Ui(game)
    ui.run()
