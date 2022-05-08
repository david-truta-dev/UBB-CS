from Boards.Cell import Cell
from Player.Computer import Computer
from Player.Human import Human


class Game:
    def __init__(self, Player1, Player2, nr_of_planes):
        self._P1 = Player1
        self._P2 = Player2
        self._number_of_planes = nr_of_planes
        self.__winner = None
        self.__turn = 1

    @property
    def P1(self):
        return self._P1

    @P1.setter
    def P1(self, value):
        self._P1 = value

    @property
    def P2(self):
        return self._P2

    @P2.setter
    def P2(self, value):
        self._P2 = value

    @property
    def turn(self):
        return self.__turn

    @property
    def number_of_planes(self):
        return self._number_of_planes

    @number_of_planes.setter
    def number_of_planes(self, value):
        self._number_of_planes = value

    @staticmethod
    def convert_coordinates(coordinates):
        """
        Converts into matrix coordinates: A3 --> 0, 2
        :param coordinates: a string of type: A3, B5...
        :return: Cell of two ints
        """
        coord1 = int(ord(coordinates[0])) - 65
        coord2 = int(coordinates[1:]) - 1
        return Cell(coord1, coord2, '*')

    @staticmethod
    def set_cells(coord, player1, player2):
        """
        This sets the value to the corresponding cell from all the boards of each player, given coord,
         which is a cell given by the Computer or Human.
        :param coord: an object of type cell, containing coordinates and a value.
        :param player1: an object of type Human.
        :param player2: an object of type Human or Computer.
        :return: -
        """
        empty = player2.my_board.check_empty(coord)
        if empty is False:
            hit = player2.my_board.check_hit(coord)
            if hit is False:
                coord.value = '#'
                player1.opponent_board.change_cell(coord)
                player2.my_board.change_cell(coord)
                player2.hit_heads += 1
            else:
                coord.value = 'x'
                player1.opponent_board.change_cell(coord)
                player2.my_board.change_cell(coord)
        else:
            coord.value = '.'
            player1.opponent_board.change_cell(coord)
            player2.my_board.change_cell(coord)

    def set_planes_computer(self):
        # check spec for set_planes_computer in Computer class
        self.P2.set_planes_computer(self._number_of_planes)

    def set_planes_human(self, player, input):
        # check spec for set_planes_human in Human class
        return player.set_planes_human(input, self.number_of_planes)

    def _make_move_human(self, player1, player2, input):
        """
        Calls the set_cells method accordingly.
        :param player1: an obj of type Human
        :param player2: an obj og type Human or Computer
        :param input: input from a human(coordinates, obj of type cell)
        :return:-
        Raises ValueError if the coordinates(input) were given once before.
        """
        coord = input
        if player2.my_board.check_good_coordinates(coord) is False:
            raise ValueError('Coordinates were read once before!')
        self.set_cells(coord, player1, player2)

    def _make_move_computer(self):
        # Generating a random coordinate:
        random_move = self._P2.generate_coordinates()
        while self._P1.my_board.check_good_coordinates(random_move) is False:
            random_move = self._P2.generate_coordinates()
        # Checking if there are any logical moves:
        logical_move = self._P2.strategy.get_next_move()
        if logical_move is None:
            # if HERE --> There are no logical moves
            # so we choose the random one
            self.set_cells(random_move, self._P2, self._P1)
            self._P2.strategy.set_next_move(random_move)
        else:
            # if HERE --> There are logical moves
            # so we choose the logical one
            self.set_cells(logical_move, self._P2, self._P1)
            self._P2.strategy.set_next_move(logical_move)

    def make_move_P1(self, input):
        """
        Calls the right function, for the first player to make a move.
        :param input: input from a player(coordinates, obj of type cell)
        :return: -
        """
        self._make_move_human(self._P1, self._P2, input)

    def make_move_P2(self, input):
        """
        Calls the right function, for the second player to make a move.
        :param input: input from a player(coordinates, obj of type cell)
        :return:-
        """
        if isinstance(self._P2, Computer):
            self._make_move_computer()
        elif isinstance(self._P2, Human):
            self._make_move_human(self._P2, self._P1, input)

    def __game_is_over(self):
        """
        Sets the winner and returns True if the game is over. Else return False.
        :return: True if game is over(3 heads were hit)
                 False otherwise.
        """
        if self._P1.hit_heads == self._number_of_planes:
            self.__winner = self._P2
            return True
        elif self._P2.hit_heads == self._number_of_planes:
            self.__winner = self._P1
            return True
        return False

    def make_moves(self, input):
        """
        Allows each player to take turns and if the game is over returns the winner.
        :param input: input from a player(coordinates, obj of type cell)
        :return: Returns the winner, if game is over.
                         None, if game is not over.
        """
        if self.__turn == 1:
            self.make_move_P1(input)
            self.__turn = 2
        elif self.__turn == 2 and isinstance(self._P2, Human):
            self.make_move_P2(input)
            self.__turn = 1
        if self.__turn == 2 and isinstance(self._P2, Computer):
            self.make_move_P2(input)
            self.__turn = 1
        over = self.__game_is_over()
        if over is True:
            return self.__winner
        return None

    def reset(self):
        """
        Resets everything that gets modified during a game, except the score.
        :return:-
        """
        self._P1.my_board.clear_board()
        self._P2.my_board.clear_board()
        self._P1.opponent_board.clear_board()
        self._P2.opponent_board.clear_board()
        self._P1.hit_heads = 0
        self._P2.hit_heads = 0
        self._P1.set_planes = 0
        if self.__winner == self._P1:
            self.__turn = 1
        elif self.__winner == self._P2:
            self.__turn = 2
        self.__winner = None

    def reset_score(self):
        """
        resets the score
        :return: -
        """
        self._P2.score = 0
        self._P1.score = 0
