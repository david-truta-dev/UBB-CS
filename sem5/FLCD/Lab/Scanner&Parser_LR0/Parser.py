# TODO: lr(0)
from Grammar import Grammar
from Item import Item
from Row import Row
from State import State, StateType
from Table import Table
from CannonicalCollection import CanonicalCollection
from ParsingTreeRow import ParsingTreeRow
from State import StateType
import itertools
import copy


class Parser:
    def __init__(self, grammar: Grammar):
        self.grammar: Grammar = grammar
        self.enrichedGrammar: Grammar = grammar.getEnrichedGrammar()
        self.orderedProductions = grammar.getOrderedProductions()

    def closure(self, item: Item) -> State:
        oldClosure = dict()
        currentClosure = {item.deepCopy(): None}
        while True:
            oldClosure = copy.deepcopy(currentClosure)
            newClosure = copy.deepcopy(currentClosure)
            for it in currentClosure.keys():
                nonTerminal = self.getDotPrecededNonTerminal(it)
                if nonTerminal is None:
                    continue
                for production in self.grammar.getProductionsFor(nonTerminal):
                    currentItem = Item(nonTerminal, list(itertools.chain(*production[1])), 0)
                    newClosure[currentItem] = None
            currentClosure = newClosure
            if str(list(oldClosure.keys())[-1]) == str(list(currentClosure.keys())[-1]):
                break
        return State(currentClosure)

    def getDotPrecededNonTerminal(self, item: Item):
        if not (0 <= item.dotPos < len(item.rhs)):
            return None
        term = item.rhs[item.dotPos]
        if term not in self.grammar.N:
            return None
        return term

    def goTo(self, state: State, element: str) -> State:
        result = dict()
        for item in state.items:
            nonTerminal = None
            if 0 <= item.dotPos < len(item.rhs):
                nonTerminal = item.rhs[item.dotPos]
            if nonTerminal == element:
                nextItem = Item(item.lhs, item.rhs, item.dotPos + 1)
                for item in self.closure(nextItem).items:
                    result[item] = None
        return State(result)

    def canonicalCollection(self) -> CanonicalCollection:
        canonicalCollection = CanonicalCollection()
        canonicalCollection.addState(
            self.closure(
                Item(
                    self.enrichedGrammar.S,
                    self.enrichedGrammar.getProductionsFor(self.enrichedGrammar.S)[0][1][0],
                    0
                )
            )
        )
        i = 0
        while i < len(canonicalCollection.states):
            for symbol in canonicalCollection.states[i].getSymbolsSucceedingTheDot():
                newState = self.goTo(canonicalCollection.states[i], symbol)

                indexInStates = -1
                for ind, s in enumerate(canonicalCollection.states):
                    if str(s) == str(newState):
                        indexInStates = ind
                        break

                if indexInStates == -1:
                    canonicalCollection.addState(newState)
                    indexInStates = len(canonicalCollection.states) - 1
                canonicalCollection.connectStates(i, symbol, indexInStates)
            i += 1
        return canonicalCollection

    def parse(self, word: list[str]) -> list[ParsingTreeRow]:
        workingStack: list[tuple[str, int]] = []
        remainingStack: list[str] = word
        productionStack: list[int] = []
        parsingTable = self.getParsingTable()
        workingStack.append(("$", 0))

        parsingTree: list[ParsingTreeRow] = []
        treeStack: list[tuple[str, int]] = []

        currentIndex = 0
        while len(remainingStack) > 0 or len(workingStack) > 0:
            if workingStack[-1][1] >= len(parsingTable.tableRow) or parsingTable.tableRow[workingStack[-1][1]] is None:
                raise Exception(f'Invalid state {workingStack[-1][1]} in the working stack')
            tableValue = parsingTable.tableRow[workingStack[-1][1]]
            if tableValue.stateType == StateType.SHIFT:
                if len(remainingStack) == 0 or remainingStack[0] is None:
                    raise Exception('Action is shift but nothing else is left in the remaining stack')
                token = remainingStack[0]
                goto = tableValue.goTo
                if token not in goto or goto[token] is None:
                    raise Exception(f'Invalid symbol {token} for goto of state {workingStack[-1][1]}')
                value = goto[token]
                workingStack.append((token, value))
                remainingStack.pop(0)
                treeStack.append((token, currentIndex))
                currentIndex += 1
            elif tableValue.stateType == StateType.ACCEPT:
                lastElement = treeStack.pop()
                parsingTree.append(ParsingTreeRow(lastElement[1], lastElement[0][0], -1, -1))
                if len(remainingStack) > 0:
                    raise Exception("Input stack is not empty but reached ACCEPT state")
                return parsingTree
            elif tableValue.stateType == StateType.REDUCE:
                productionToReduceTo = self.orderedProductions[tableValue.reductionIndex]
                parentIndex = currentIndex
                currentIndex += 1
                lastIndex = -1
                for _ in range(len(productionToReduceTo[1])):
                    workingStack.pop()
                    lastElement = treeStack.pop()
                    parsingTree.append(ParsingTreeRow(lastElement[1], lastElement[0][0], parentIndex, lastIndex))
                    lastIndex = lastElement[1]
                treeStack.append((productionToReduceTo[0], parentIndex))
                previous = workingStack[-1]
                workingStack.append(
                    (productionToReduceTo[0], parsingTable.tableRow[previous[1]].goTo[productionToReduceTo[0][0]])
                )
                productionStack = [tableValue.reductionIndex] + productionStack
            else:
                raise Exception(str(tableValue.stateType))
        raise Exception('Something went terribly wrong')

    def getParsingTable(self) -> Table:
        canonicalCollection = self.canonicalCollection()
        table = Table()
        for k in canonicalCollection.adjacencyList.keys():
            state = canonicalCollection.states[k[0]]
            if k[0] not in table.tableRow:
                table.tableRow[k[0]] = Row(state.stateType, {}, None)
            table.tableRow[k[0]].goTo[k[1]] = canonicalCollection.adjacencyList[k]
        for i, state in enumerate(canonicalCollection.states):
            if state.stateType == StateType.REDUCE:
                index = None
                try:
                    index = self.orderedProductions.index(
                        ([list(state.items.keys())[0].lhs], list(state.items.keys())[0].rhs))
                except ValueError:
                    pass
                table.tableRow[i] = Row(state.stateType, None, index)
            if state.stateType == StateType.ACCEPT:
                table.tableRow[i] = Row(state.stateType, None, None)

        return table
