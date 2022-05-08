from dataclasses import dataclass


@dataclass
class Cell:
    line: int
    column: int
    value: str
