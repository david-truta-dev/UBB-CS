class Grammar:
    enrichedGrammarStartingSymbol = 'S0'

    @staticmethod
    def parseLine(line) -> list[str]:
        return [value.strip() for value in line.split('$')[1].strip().split('#')[0].strip().split(' ')]

    @staticmethod
    def fromFile(fileName) -> 'Grammar':
        with open(fileName) as file:
            N = Grammar.parseLine(file.readline())
            E = Grammar.parseLine(file.readline())
            S = file.readline().split('=')[1].strip()
            P = Grammar.parseRules([line.strip() for line in file][1:-1])

            return Grammar(N, E, P, S)

    @staticmethod
    def parseRules(rules):
        result = []

        for rule in rules:
            lhs, rhs = rule.split('->')
            lhs = lhs.strip().split(' ')
            rhs = [v.split(' ') for v in [value.strip() for value in rhs.split('|')]]

            result.append((lhs, rhs))

        return result

    def __init__(self, N: list[str], E: list[str], P: list[tuple[list[str], list[list[str]]]], S: str):
        self.N: list[str] = N
        self.E: list[str] = E
        self.P: list[tuple[list[str], list[list[str]]]] = P
        self.S: str = S

    def isNonTerminal(self, value):
        return value in self.N

    def isTerminal(self, value):
        return value in self.E

    def getProductionsFor(self, nonTerminal):
        if not self.isNonTerminal(nonTerminal):
            raise Exception(f'Can only show productions for non-terminals: {nonTerminal} is not non-terminal')
        return [prod for prod in self.P if prod[0][0] == nonTerminal]

    def showProductionsFor(self, nonTerminal):
        productions = self.getProductionsFor(nonTerminal)
        print(', '.join([' -> '.join(prod) for prod in productions]))

    def getOrderedProductions(self) -> list[tuple[list[str], list[list[str]]]]:
        productionList: list[tuple[list[str], list[list[str]]]] = []
        for production in self.P:
            for rhs in production[1]:
                productionList.append((production[0], rhs))
        return productionList

    def checkIfCFG(self):
        checkStartingSymbol = False

        for rule in self.P:
            lhs, rhs = rule
            for l in lhs:
                if self.S == l:
                    checkStartingSymbol = True
                    break
            if checkStartingSymbol:
                break

        if not checkStartingSymbol:
            return False

        for rule in self.P:
            lhs, rhs = rule
            if len(lhs) > 1:
                return False
            for l in lhs:
                if l not in self.N:
                    return False

            for rh in rhs:
                for r in rh:
                    if not (r in self.N or r in self.E or r == 'e'):
                        return False

        return True
    
    def getEnrichedGrammar(self) -> 'Grammar':
        if self.S == Grammar.enrichedGrammarStartingSymbol:
            raise Exception('Grammar is already enriched')
        newGrammar = Grammar(self.N, self.E, self.P, Grammar.enrichedGrammarStartingSymbol)
        newGrammar.N.append(Grammar.enrichedGrammarStartingSymbol)
        newGrammar.P.append(([Grammar.enrichedGrammarStartingSymbol], [[self.S]]))
        return newGrammar

    def __str__(self):
        P = ''
        for prod in self.P:
            first = ' '.join(prod[0])
            second = ''
            for rhs in prod[1]:
                second += ' '.join(rhs) + ' | '
            second = second[:-2]
            P += '\t' + first + ' -> ' + second + '\n'
        return 'N = { ' + ', '.join(self.N) + ' }\n' \
               + 'E = { ' + ', '.join(self.E) + ' }\n' \
               + 'P = {\n' + P + '}\n' \
               + 'S = ' + str(self.S) + '\n'
