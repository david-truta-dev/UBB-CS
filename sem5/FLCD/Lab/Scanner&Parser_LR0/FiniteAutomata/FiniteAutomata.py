from State import State

class FiniteAutomata:
    def __init__(self):
        self.alphabet = set()
        self.states = dict()

    def add_state(self, state):
        self.states[state.token] = state

    def get_state(self, token):
        if token not in self.states:
            raise Exception(f"{token} is not a valid state")
        return self.states[token] 

    def alphabet_append(self, char):
        self.alphabet.add(char)

    def add_transition(self, src, dest, how):
        if how not in self.alphabet:
            raise Exception(f"invalid char: {how} does not exist in alphabet")
        self.get_state(src).add_transition(self.get_state(dest), how)

    def is_DFA(self):
        for state in self.states.values():
            if not state.is_DFA():
                return False
        return True

    def accept(self, word):
        now = None
        for state in self.states.values():
            if state.initial:
                now = state
                break
        if now is None:
            return False
        idx = 0
        while idx < len(word):
            edges = now.transitions
            if word[idx] in edges.keys():
                now = edges[word[idx]][0]
                idx += 1 
            else:
                return False
        return idx == len(word) and now.final


def read_FA(file_path):
    FA = FiniteAutomata()
    with open(file_path) as file:
        alphabet_line = file.readline()
        for char in alphabet_line.split(","):
            char = char.strip()
            assert len(char) <= 1
            FA.alphabet_append(char)

        state_line = file.readline()
        for token in state_line.split(","):
            token = token.strip()
            FA.add_state(State(token))

        initial_line = file.readline()
        initial_line = initial_line.strip()
        FA.get_state(initial_line).initial = True

        final_line = file.readline()
        for token in final_line.split(","):
            token = token.strip()
            FA.get_state(token).final = True

        transition_line = file.readline()
        while transition_line:
            src, how, where = transition_line.split(",")
            where = where.strip()
            assert how in FA.alphabet
            FA.add_transition(src, where, how)
            transition_line = file.readline()

    return FA


if __name__ == '__main__':
    FA = read_FA('input/fa2.in')
    print(FA.accept(''))
    print(FA.is_DFA())
