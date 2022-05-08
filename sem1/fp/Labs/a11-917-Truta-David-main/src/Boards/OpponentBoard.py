from Boards.Board import Board


class OpponentBoard(Board):

    def __init__(self, length, width):
        super().__init__(length, width)

    def check_inside_board(self, cell):
        return super().check_inside_board(cell)

    def change_cell(self, cell):
        super().change_cell(cell)

    def clear_board(self):
        super().clear_board()

    def check_empty(self, cell):
        return super()._check_empty_cell(cell)

    def check_hit(self, cell):
        """
        Checks if the corresponding cell in the board is a part of a plane's body, but in the op_board.
        :param cell: an object of type cell
        :return: True if cell is a part of a plane's body, False otherwise
        """
        if self._cells[cell.line][cell.column].value == 'x':
            return True
        return False

    def check_head(self, cell):
        """
        Checks if the corresponding cell in the board is a part of a plane's body, but in the op_board.
        :param cell: an object of type cell
        :return: True if cell is a part of a plane's body, False otherwise
        """
        if self._cells[cell.line][cell.column].value == '#':
            return True
        return False

    def __str__(self):
        return super().__str__()
