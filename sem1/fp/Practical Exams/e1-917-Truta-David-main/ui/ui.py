from domain.board import GameOver


class Ui:
    def __init__(self, game):
        self._game = game

    def ui_place_apples_snake(self):
        self._game.place_apples_snake()

    def ui_move_snake(self, squares):
        self._game.move_snake(squares)
        print('Move was successful!')

    def ui_change_snake_direction(self, direction):
        self._game.change_snake_direction(direction)
        print('Direction change was successful!')

    def run(self):
        self.ui_place_apples_snake()
        directions = ['up', 'right', 'down', 'left']
        print('=================== Welcome to snake ! :) ==================')
        while True:
            print(self._game.board)
            command = input('>').lower().strip().split(' ')
            if command[0] == 'x':
                break
            elif command[0] == 'move':
                if len(command) > 1:
                    if command[1].isnumeric() is True and command[1] != '0':
                        try:
                            self.ui_move_snake(int(command[1]))
                        except ValueError as ve:
                            print(ve)
                        except GameOver as go:
                            print(go)
                            break
                    else:
                        print('The argument after move should be a natural number!')
                else:
                    try:
                        self.ui_move_snake(1)
                    except ValueError as ve:
                        print(ve)
                    except GameOver as go:
                        print(go)
                        break
            elif command[0] in directions:
                try:
                    self.ui_change_snake_direction(command[0])
                except ValueError as ve:
                    print(ve)
                except GameOver as go:
                    print(go)
                    break
            else:
                print('Enter a relevant command')
