class Game:
    def __init__(self, board):
        self._board = board

    @property
    def board(self):
        return self._board

    def place_apples_snake(self):
        self.board.place_snake()
        self.board.place_apples()

    def for_actual_move_snake(self, squares, line_add, column_add):
        for i in range(squares):
            # Checking for apple AND Changing the head:
            if self.board.check_apple(self.board.snake[0][0] + line_add, self.board.snake[0][1] + column_add) is False:
                # Popping last part of snake:
                self.board.change_cell(self.board.snake[-1][0], self.board.snake[-1][1], ' ')
                self.board.snake.pop()
            self.board.change_cell(self.board.snake[0][0], self.board.snake[0][1], '+')
            self.board.snake.insert(0, (self.board.snake[0][0] + line_add, self.board.snake[0][1] + column_add))
            self.board.change_cell(self.board.snake[0][0], self.board.snake[0][1], '*')

    def actual_move_snake(self, squares):
        if self.board.facing == 'up':
            self.for_actual_move_snake(squares, -1, 0)
        elif self.board.facing == 'right':
            self.for_actual_move_snake(squares, 0, 1)
        elif self.board.facing == 'down':
            self.for_actual_move_snake(squares, +1, 0)
        elif self.board.facing == 'left':
            self.for_actual_move_snake(squares, 0, -1)

    def change_snake_direction(self, direction):
        if direction == self.board.facing:
            return None
        if self.board.check_direction(direction) is False:
            raise ValueError("It can't do 180 :(")
        self.board.facing = direction
        self.actual_move_snake(1)

    def move_snake(self, squares):
        if self.board.check_valid_move(squares) is True:
            self.actual_move_snake(squares)
        else:
            raise ValueError('The move is not valid!')
