from State import State


class CanonicalCollection:
    def __init__(self):
        self.states: list[State] = []
        self.adjacencyList: dict[tuple[int, str], int] = dict()

    def addState(self, state: State):
        self.states.append(state)

    def connectStates(self, indexFirstState: int, symbol: str, indexSecondState: int):
        self.adjacencyList[(indexFirstState, symbol)] = indexSecondState
