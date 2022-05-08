import sys

from AiStrategies.NormalStrategy import NormalStrategy
from Boards.Board import BoardError
from Boards.MyBoard import MyBoard
from Player.Computer import Computer
from Player.Human import Human


class ConsoleUI:
    def __init__(self, game):
        self.__game = game

    @staticmethod
    def startUp():
        print("\t\t\t  Welcome to Planes!\n\n"
              "----------Enter the following keys to----------\n"
              "\t\t\t\tPLAY -  'p' \n"
              "\t\t\tHow to Play? -  'h' \n"
              "\t\t\t\tEXIT -  'x' \n")

    def play(self):
        player2 = input("---------- Who do you want to play with? ----------\n"
                        "\t\t\t\tAnother player -  'p' \n"
                        "\t\t\t\tComputer -  'c' \n"
                        "\t\t\t\tGo Back -  'b' \n"
                        "\n>>>").strip().lower()
        if player2 == 'b':
            self.run()
        elif player2 == 'c':
            self.__game.P2 = Computer(self.__game.P2.my_board, self.__game.P2.opponent_board,
                                      NormalStrategy(self.__game.P2.opponent_board))
            self.ui_start_game_ai()
        elif player2 == 'p':
            self.__game.P2 = Human(self.__game.P2.my_board, self.__game.P2.opponent_board)
            self.ui_start_game_humans()
        else:
            print("\tEnter a relevant command!")
            self.play()

    def howToPlay(self):
        b = MyBoard(10, 10)
        print("\t\tClick the link below see the rules:\n"
              "\thttps://ro.wikipedia.org/wiki/Avioane_(joc)\n")
        print("Here is how planes look:")
        print("\t    *            0       The * is the plane's head,\n"
              "\t0 0 0 0 0    0   0 .     and 0 is a part of the plane's body.\n"
              "\t    0 .   .  x 0 0 #     If a cell is: # --> plane's head was hit .\n"
              "\t  x 0 0      0   x                     x --> part of the plane's body was hit.\n"
              "\t                 0                     . --> missed shot.\n"
              "When you fit a plane on the board, give the coordinates of the head, and the way it's facing:\n"
              "up, left, right or down.\n\n"
              "After that, the game begins. Your board is the first one, and the other is Player's. \n"
              "Player 1 is first to give coordinates. Coordinates are given as a set of a letter and number.\n"
              "Examples: A4, C3, J9. \nHere is how an empty board looks like:\n", b, "\n", sep='')
        input('\tPress Enter to go back.')
        self.main_menu()

    def main_menu(self):
        self.startUp()
        command = input('>>>').lower().strip()
        if command == 'p':
            self.play()
        elif command == 'h':
            self.howToPlay()
        elif command == 'x':
            sys.exit()
        else:
            print('\t\tEnter a valid command !\n')
            self.main_menu()

    def print_winner_score(self, winner):
        if winner == self.__game.P1:
            print('---------------- Player 1 WON ! ----------------')
            self.__game.P1.score += 1
        elif winner == self.__game.P2:
            self.__game.P2.score += 1
            if isinstance(self.__game.P2.score, Human):
                print('---------------- Player 2 WON ! ----------------')
                print('Player2:', self.__game.P2.score)
            elif isinstance(self.__game.P2.score, Computer):
                print('---------------- Computer WON :( ----------------')
                print('Computer:', self.__game.P2.score)
        print('Player1:', self.__game.P1.score)
        if isinstance(self.__game.P2, Human):
            print('Player2:', self.__game.P2.score)
        else:
            print('Computer:', self.__game.P2.score)

    def over_screen_menu(self, winner):

        self.print_winner_score(winner)

        command = input('--------------- Enter the following to --------------'
                        "\n\t\t\t\t'a' - Play another round"
                        "\n\t\t\t\t'm' - Go to Main Menu"
                        "\n\t\t\t\t'x' - Quit Game"
                        "\n>")
        while command != 'a' and command != 'm' and command != 'x':
            print('Enter a relevant command!')
            command = input('>').strip().lower()
        if command == 'a':
            self.__game.reset()
            if isinstance(self.__game.P2, Computer):
                self.ui_start_game_ai()
            elif isinstance(self.__game.P2, Human):
                self.ui_start_game_humans()
        elif command == 'm':
            self.__game.reset()
            self.__game.reset_score()
            self.main_menu()
        elif command == 'x':
            sys.exit()

    def read_coordinates(self):
        """
        Reads input and converts from 'A3' to '02' (example), with the convert-coordinates method.
        :return: Matrix coordinates
        """
        while True:
            coordinates = str(input('Coordinates:')).strip().upper()
            if len(coordinates) >= 2 and coordinates[0].isalpha() is True and coordinates[1:].isnumeric() is True:
                try:
                    conv_coord = self.__game.convert_coordinates(coordinates)
                    self.__game.P1.my_board.check_inside_board(conv_coord)
                    break
                except BoardError as be:
                    print(be)
            elif coordinates == 'X':
                sys.exit()
        return conv_coord

    @staticmethod
    def read_plane_facing():
        """
        Reads and returns a valid direction for a plane.
        :return: (string) representing the facing of the plane.
        """
        print("Enter the way the plane is facing. 'up'|'left'|'right'|'down'")
        while True:
            facing = input('>')
            if facing == 'up' or facing == 'right' or facing == 'down' or facing == 'left':
                break
            else:
                print('Enter a relevant command!')
        return facing

    def ui_read_input(self):
        return [self.read_coordinates(), self.read_plane_facing()]

    def ui_set_planes_human(self, player):
        while True:
            print(player.my_board)
            print('Give coordinates of plane', player.set_planes + 1, '.')
            done = self.__game.set_planes_human(player, self.ui_read_input())
            if isinstance(done, BoardError):
                print(done)
            elif done is True:
                break
        player.set_planes = 0

    def ui_start_game(self):

        winner = None
        while winner is None:
            print("------------Player" + str(self.__game.turn) + "'s Turn-------------", sep="")
            if isinstance(self.__game.P2, Computer):
                print(self.__game.P1.my_board, '\n', self.__game.P1.opponent_board, sep='')
            elif self.__game.turn == 1:
                print(self.__game.P1.my_board, '\n', self.__game.P1.opponent_board, sep='')
            else:
                print(self.__game.P2.my_board, '\n', self.__game.P2.opponent_board, sep='')
            while True:
                try:
                    winner = self.__game.make_moves(self.read_coordinates())
                    break
                except ValueError as ve:
                    print(ve)

            if isinstance(self.__game.P2, Human):
                input('\n\n\n\n\n\n\n\n\n\n\n\n\n'
                      '\n\n\n\n\n\n\n\n\n\n\n\n\n'
                      '\n\n\n\n\n\n\n\n'
                      '\t\tTurn away and give the control to the other player.'
                      '\n\tThen the other player should press ENTER.')
        self.over_screen_menu(winner)

    def ui_start_game_ai(self):
        print('---------------------- STARTING GAME ----------------------')
        print('------------------ Set Planes - Player 1 ------------------')
        self.ui_set_planes_human(self.__game.P1)

        self.__game.set_planes_computer()
        print(self.__game.P2.my_board)

        self.ui_start_game()

    def ui_start_game_humans(self):
        print('---------------------- STARTING GAME ----------------------')
        print('------------------ Set Planes - Player 1 ------------------')
        self.ui_set_planes_human(self.__game.P1)
        print(self.__game.P1.my_board)
        input('\n\n\n\n\n\n\n\n\n\n\n\n\n'
              '\n\n\n\n\n\n\n\n\n\n\n\n\n'
              '\n\n\n\n\n\n\n\n'
              'Turn away and let the other player set their planes.\n\tPress ENTER to set planes')

        print('------------------ Set Planes - Player 2 ------------------')
        self.ui_set_planes_human(self.__game.P2)
        print(self.__game.P2.my_board)
        input('\n\n\n\n\n\n\n\n\n\n\n\n\n'
              '\n\n\n\n\n\n\n\n\n\n\n\n\n'
              '\n\n\n\n\n\n\n\n'
              'Turn away and let the other player give coordinates.\n\tPress ENTER to continue.')

        self.ui_start_game()

    def run(self):
        self.main_menu()
