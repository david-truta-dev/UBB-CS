import random

from domain.cell import Cell


class StoreException(Exception):
    pass


class GameOver(StoreException):
    pass


class Board:
    def __init__(self, DIM, apple_count):
        self._lines = DIM
        self._columns = DIM
        self._apple_count = apple_count
        self._snake = None
        self._snake_length = 3
        self._facing = 'up'
        self._cells = self._create_board()

    @property
    def facing(self):
        return self._facing

    @facing.setter
    def facing(self, value):
        self._facing = value

    @property
    def snake(self):
        return self._snake

    @snake.setter
    def snake(self, value):
        self._snake = value

    def _create_board(self):
        return [[Cell(line, column, ' ') for column in range(self._columns)]
                for line in range(self._lines)]

    def place_snake(self):
        self._cells[self._lines // 2 - 1][self._lines // 2].value = '*'
        self._cells[self._lines // 2][self._lines // 2].value = '+'
        self._cells[self._lines // 2 + 1][self._lines // 2].value = '+'
        self._snake = [(self._lines // 2 - 1, self._lines // 2), (self._lines // 2, self._lines // 2),
                       (self._lines // 2 + 1, self._lines // 2)]

    def check_body_segment(self, line, column):
        if self._cells[line][column].value == '+':
            return True
        return False

    def check_direction(self, direction):
        if direction == 'up':
            if self.facing != 'right' and self._facing != 'left':
                return False
            if self.snake[0][0] == 0 or self.check_body_segment(self.snake[0][0] - 1, self.snake[0][1]) is True:
                raise GameOver('GAME OVER !!! :(')
        elif direction == 'right':
            if self.facing != 'up' and self._facing != 'down':
                return False
            if self.snake[0][1] == self._lines - 1 or self.check_body_segment(self.snake[0][0], self.snake[0][1] + 1) is True:
                raise GameOver('GAME OVER !!! :(')
        elif direction == 'down':
            if self.facing != 'left' and self._facing != 'right':
                return False
            if self.snake[0][0] == self._lines - 1 or self.check_body_segment(self.snake[0][0] + 1, self.snake[0][1]) is True:
                raise GameOver('GAME OVER !!! :(')
        elif direction == 'left':
            if self.facing != 'up' and self._facing != 'down':
                return False
            if self.snake[0][1] == 0 or self.check_body_segment(self.snake[0][0], self.snake[0][1] - 1) is True:
                raise GameOver('GAME OVER !!! :(')
        return True

    def change_cell(self, line, column, value):
        self._cells[line][column].value = value

    def pot_snake_on_board(self):
        for c in self._snake:
            pass

    def check_empty(self, line, column):
        if self._cells[line][column].value == ' ':
            return True
        return False

    def check_valid_move(self, square):
        if self.facing == 'up':
            if self._snake[0][0] - square < 0:
                raise GameOver('GAME OVER !!! :(')
            for i in range(square+1):
                if self.check_body_segment(self.snake[0][0] - i, self.snake[0][1]) is True:
                    raise GameOver('GAME OVER !!! :(')
            return True
        elif self.facing == 'right':
            if self._snake[0][1] + square >= self._lines:
                raise GameOver('GAME OVER !!! :(')
            for i in range(square+1):
                if self.check_body_segment(self.snake[0][0], self.snake[0][1] + i) is True:
                    raise GameOver('GAME OVER !!! :(')
            return True
        elif self.facing == 'down':
            if self._snake[0][0] + square >= self._lines:
                raise GameOver('GAME OVER !!! :(')
            for i in range(square+1):
                if self.check_body_segment(self.snake[0][0] + i, self.snake[0][1]) is True:
                    raise GameOver('GAME OVER !!! :(')
            return True
        elif self.facing == 'left':
            if self._snake[0][1] - square < 0:
                raise GameOver('GAME OVER !!! :(')
            for i in range(square+1):
                if self.check_body_segment(self.snake[0][0], self.snake[0][1]- i) is True:
                    raise GameOver('GAME OVER !!! :(')
            return True

    def check_apple(self, line, column):
        if self._cells[line][column].value == '.':
            return True
        return False

    def generate_apple_position(self):
        line = random.randint(0, self._lines - 1)
        column = random.randint(0, self._lines - 1)
        while self.check_empty(line, column) is False:
            line = random.randint(0, self._lines - 1)
            column = random.randint(0, self._lines - 1)
        return line, column

    def place_apples(self):
        for i in range(self._apple_count):
            line, column = self.generate_apple_position()
            self._cells[line][column].value = '.'

    def __str__(self):
        square_top = "+---"
        square_top_end = "+---+\n"
        square_middle = "| "
        square_middle_end = "|\n"
        res, i = '', 0
        for line in self._cells:
            for i in range(self._lines - 1):
                res += square_top
            res += square_top_end
            for i in range(self._lines):
                res += square_middle + line[i].value + " "
            res += square_middle_end

        for i in range(self._lines - 1):
            res += square_top
        res += square_top_end
        return res
