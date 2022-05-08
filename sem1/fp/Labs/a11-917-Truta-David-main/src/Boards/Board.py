from Boards.Cell import Cell


class StoreException(Exception):
    pass


class BoardError(StoreException):
    pass


class Board:

    def __init__(self, length, width):
        self._length = length
        self._width = width
        self._cells = self._create_board()

    def _create_board(self):
        """
        Creates an empty board, full of empty spaces(strings).
        :return: A list of lists(matrix in python), representing the board
        """
        return [[Cell(line, column, ' ') for column in range(self._width)]
                for line in range(self._length)]

    def check_inside_board(self, cell):
        """
        Checks if a given cell object is inside the board.
        :param cell: an object of type cell
        :return: True - if cell is inside the board
        raises BoardError if not inside board.
        """
        if 0 <= cell.line < self._length and 0 <= cell.column < self._width:
            return True
        raise BoardError('The plane is not inside the board! Give other coordinates!')

    def _check_empty_cell(self, cell):
        """
        Checks if a given cell object has the value ' ', which means it's empty.
        :param cell: an object of type cell
        :return: True - if cell is empty
        raises BoardError if not empty.
        """
        if self._cells[cell.line][cell.column].value == ' ':
            return True
        raise BoardError('The plane collides with another plane! Give other coordinates!')

    def clear_board(self):
        """
        Sets value of all cells to ' ', in other words, it clears the board.
        :return:-
        """
        for i in range(self._length):
            for j in range(self._width):
                self._cells[i][j].value = ' '

    def check_plane_fits(self, plane):
        """
        Checks if the plane fits inside the board, without colliding.
        :param plane: Object of type plane
        :return:-
        Raises BoardError if the plane does not fit
        """
        self.check_inside_board(plane.head)
        self._check_empty_cell(plane.head)
        for cell in plane.body():
            self.check_inside_board(cell)
            self._check_empty_cell(cell)

    def change_cell(self, cell):
        """
        It changes the value of the corresponding cell on the board to the value of the given cell
        :param cell: an object of type cell
        :return:-
        """
        self._cells[cell.line][cell.column].value = cell.value

    def set_plane(self, plane):
        """
        Sets a plane inside the board, by setting the corresponding cells.
        :param plane: Object of type plane
        :return:-
        Raises BoardError if the plane doesn't fit.
        """
        self.check_plane_fits(plane)
        self._cells[plane.head.line][plane.head.column] = plane.head
        for cell in plane.body():
            self._cells[cell.line][cell.column] = cell

    def __str__(self):
        """
        Prints board
        :return: the board in the correct form
        """
        res = "  1 2 3 4 5 6 7 8 9 10\n" \
              "  ____________________\n"
        lines, i = "ABCDEFGHIJ", 0
        for line in self._cells:
            s = lines[i] + '|' + " ".join([cell.value for cell in line]) + "|\n"
            res += s
            i += 1
        res += " |-------------------|"
        return res
