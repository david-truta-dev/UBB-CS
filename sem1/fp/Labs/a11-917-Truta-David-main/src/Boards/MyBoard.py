
"""
    In here is the MyBoard class, which represents the board of the player, and it inherits the methods and props of
    Board class.
"""


from Boards.Board import Board, BoardError


class MyBoard(Board):

    def __init__(self, length, width):
        super().__init__(length, width)

    def check_inside_board(self, cell):
        return super().check_inside_board(cell)

    def check_good_coordinates(self, cell):
        """
        Checks if the value of the corresponding cell in the board is empty, without raising any exceptions.
        :param cell: an object of type cell
        :return: True if coordinates are good, False otherwise
        """
        if self._cells[cell.line][cell.column].value == '.' or self._cells[cell.line][cell.column].value == '#' \
                or self._cells[cell.line][cell.column].value == 'x':
            return False
        return True

    def clear_board(self):
        super().clear_board()

    def check_empty(self, cell):
        """
        Checks if a cells value is empty in myBoard.
        :param cell: object of typ Cell
        :return: True if it is empty, False otherwise
        """
        try:
            super()._check_empty_cell(cell)
            return True
        except BoardError:
            return False

    def check_hit(self, cell):
        """
        Checks if the corresponding cell in the board is a part of a plane's body.
        :param cell: an object of type cell
        :return: True if cell is a part of a plane's body, False otherwise
        """
        if self._cells[cell.line][cell.column].value == '0':
            return True
        return False

    def change_cell(self, cell):
        super().change_cell(cell)

    def set_plane(self, plane):
        super().set_plane(plane)

    def __str__(self):
        return super().__str__()
