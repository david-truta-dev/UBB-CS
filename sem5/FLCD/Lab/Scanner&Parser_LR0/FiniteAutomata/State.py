class State:
    def __init__(self, token, initial=False, final=False):
        self.transitions = dict()
        self.token = token
        self.final = final
        self.initial = initial

    def add_transition(self, state, char):
        if char not in self.transitions:
            self.transitions[char] = []
        self.transitions[char].append(state)
    
    def is_DFA(self):
        for _, value in self.transitions.items():
            if len(value) > 1:
                return False
        return True

    def __str__(self):
        return f"{self.token} is_initial: {self.initial} is_final: {self.final}"
