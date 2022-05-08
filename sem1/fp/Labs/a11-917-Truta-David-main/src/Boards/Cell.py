
"""
    This module contains the cell for the class Cell, which represents a cell on the board.
"""

from dataclasses import dataclass


@dataclass
class Cell:
    line: int
    column: int
    value: str = ' '

    def __str__(self):
        return self.value
