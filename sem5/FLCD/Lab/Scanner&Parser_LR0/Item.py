import copy


class Item:
    def __init__(self, lhs: str, rhs: list, dotPos: int):
        self.lhs = lhs
        self.rhs = rhs
        self.dotPos = dotPos

    def deepCopy(self):
        return Item(copy.deepcopy(self.lhs), copy.deepcopy(self.rhs), copy.deepcopy(self.dotPos))

    def __str__(self):
        rhs1 = " ".join(x for x in self.rhs[:self.dotPos])
        rhs2 = " ".join(x for x in self.rhs[self.dotPos:])
        return f'{self.lhs} -> {rhs1}.{rhs2}'

    def __hash__(self):
        return hash(self.__str__())

    def __eq__(self, other):
        return (self.__str__() == other.__str__())
