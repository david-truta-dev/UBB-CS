from Grammar import Grammar
from Parser import Parser

if __name__ == '__main__':
    input_file = 'input/g3.in'
    # input_file = 'input/g1.in'
    # input_file = 'input/g2.in'
    grammar = Grammar.fromFile(input_file)
    
    # print(grammar)
    # print(grammar.checkIfCFG())
    # print('[===================================]\n\n')

    parser = Parser(grammar)
    canonicalCollection = parser.canonicalCollection()
    print('states:')
    for i, s in enumerate(canonicalCollection.states):
        print(f'#{i} {s}')
    print(f'state transitions: {canonicalCollection.adjacencyList}')
    print('[===================================]\n\n')

    print(grammar.getOrderedProductions())
    print('parsing table:')
    print(parser.getParsingTable())

    result = []
    try:
        parseTree = parser.parse(['a', 'b', 'b', 'c'])
        # parseTree = parser.parse(['a', 'b', 'b', 'c', 'a'])
        # parseTree = parser.parse(['int', 'e', 'e'])
        # parseTree = parser.parse(['{', 'bool', 'identifier', ';', '}'])
        # parseTree = parser.parse(['{', 'print', '(', 'identifier', '+', 'constant', ')', ';', '}'])
        # parseTree = parser.parse(['{', 'identifier', '=', 'identifier', '+', 'constant', ';', '}'])
        # parseTree = parser.parse(['{', 'if', '(', 'identifier', '<=', 'identifier', ';', ')', '{', 'print', '(', 'constant', ')', ';', '}', '}'])
        # parseTree = parser.parse(['{', 'while', '(', 'identifier', '<=', 'identifier', ';', ')', '{', 'print', '(', 'constant', ')', ';', '}', '}'])

        for row in parseTree:
            result.append(f'{row.index}: {row.info}, {row.parent}, {row.rightSibling}')
        for r in sorted(result, key=lambda x: int(x.split(':')[0])):
            print(r)
    except Exception as e:
        print(e)
