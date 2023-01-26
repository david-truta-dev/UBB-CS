from dataclasses import dataclass


@dataclass
class ParsingTreeRow:
    index: int
    info: str
    parent: int
    rightSibling: int
