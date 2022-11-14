class FiniteAutomata:
    def __init__(self, Q, E, S, q0, F):
        self.Q = Q
        self.E = E
        self.S = S
        self.q0 = q0
        self.F = F

    @staticmethod
    def parseLine(line):
        return [value.strip() for value in line.strip().split('=')[1].strip()[1:-1].strip().split(',')]

    @staticmethod
    def fromFile(fileName):
        with open(fileName) as file:
            Q = FiniteAutomata.parseLine(file.readline())
            E = FiniteAutomata.parseLine(file.readline())
            q0 = file.readline().split('=')[1].strip()
            F = FiniteAutomata.parseLine(file.readline())

            restOfFile = FiniteAutomata.parseLine(''.join([line for line in file]))
            S = FiniteAutomata.parseTransitions(restOfFile)
            return FiniteAutomata(Q, E, S, q0, F)

    @staticmethod
    def parseTransitions(parts):
        result = []
        transitions = []
        index = 0

        while index < len(parts):
            transitions.append(parts[index] + ',' + parts[index + 1])
            index += 2

        for transition in transitions:
            lhs, rhs = transition.split('->')
            state2 = rhs.strip()
            state1, route = [value.strip() for value in lhs.strip()[1:-1].split(',')]

            toAdd = ((state1, route), state2)
            for t in result:
                if t[0] == toAdd[0]:
                    raise Exception('Transaction already exists')

            result.append(toAdd)

        return result

    def __str__(self):
        return 'Q = { ' + ', '.join(self.Q) + ' }\n' \
               + 'E = { ' + ', '.join(self.E) + ' }\n' \
               + 'F = { ' + ', '.join(self.F) + ' }\n' \
               + 'S = { ' + ', '.join([' -> '.join([str(part) for part in trans]) for trans in self.S]) + ' }\n'\
               + 'q0 = ' + str(self.q0) + '\n'
