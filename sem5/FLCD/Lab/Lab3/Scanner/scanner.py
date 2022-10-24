import re
from enum import Enum

from symbol_table import SymbolTable


class PifElement(Enum):
    CONSTANT = 'constant'
    IDENTIFIER = 'identifier'


class Scanner:
    def __init__(self, file_string):
        self._programInternalForm = []
        self._file = file_string
        self._symbolTable = SymbolTable()
        self._tokens = ['+', '-', '*', '/', '%', '<', '>', '>=', '<=', '!=', '==', '&&', '||', 'int', 'if',
                        'char', 'const', 'string', 'PROGRAM', 'bool', 'read', 'write', 'array', 'else', 'return', '(',
                        ')', '{', '}', '[', ']', ':', ';']
        try:
            self.scan()
            print("lexically correct")
        except ValueError as err:
            print(err)

    def scan(self):
        elements = re.split('\n', self._file)
        elements = [el for el in elements if el != '' and el != ' ']

        for element in elements:
            tokens = self.detect_tokens(element)
            for token in tokens:
                if token in self._tokens:
                    self.gen_pif(token, 0)
                else:
                    if self.detect_identifier(token):
                        self.gen_pif(PifElement.IDENTIFIER.value, self._symbolTable.add(token))
                    else:
                        # TODO complete
                        raise ValueError(
                            'Lexical Error on line ' + str(elements.index(element)) + ' at token ' + token)
        print(self._symbolTable)
        self.write_files(self._symbolTable)

    @staticmethod
    def write_files(symbol_table, pif):
        with open('PIF.out', 'w') as file:
            file.write(str(pif))
        with open('ST.out', 'w') as file:
            file.write(str(symbol_table))

    def detect_tokens(self, string):
        elements = string
        n = len(elements) - 1
        for i in range(n):
            if i > n:
                break

            if elements[i] == '<':
                if elements[i + 1] == '=':
                    elements[i] += elements[i + 1]
                    del elements[i + 1]
                    n -= 1
                    continue

            if elements[i] == '>':
                if elements[i + 1] == '=':
                    elements[i] += elements[i + 1]
                    del elements[i + 1]
                    n -= 1
                    continue

            if elements[i] == '!':
                elements[i] += elements[i + 1]
                del elements[i + 1]
                n -= 1
                continue

            if elements[i] == '=':
                if elements[i + 1] == '=':
                    elements[i] += elements[i + 1]
                    del elements[i + 1]
                    n -= 1
                    continue

            self.token_keyword_detector(elements, 'if', i, n)

            self.token_keyword_detector(elements, 'int', i, n)

            self.token_keyword_detector(elements, 'char', i, n)

            self.token_keyword_detector(elements, 'const', i, n)

            self.token_keyword_detector(elements, 'string', i, n)

            self.token_keyword_detector(elements, 'PROGRAM', i, n)

            self.token_keyword_detector(elements, 'bool', i, n)

            self.token_keyword_detector(elements, 'read', i, n)

            self.token_keyword_detector(elements, 'write', i, n)

            self.token_keyword_detector(elements, 'array', i, n)

            self.token_keyword_detector(elements, 'else', i, n)

            self.token_keyword_detector(elements, 'return', i, n)

            # TODO continue this
        return elements

    @staticmethod
    def detect_identifier(string):
        match = re.match('^_?[a-zA-Z]+[a-zA-Z0-9_]*$', string)
        return match is not None

    @staticmethod
    def detect_constant(string):
        pass
        # TODO

    @staticmethod
    def token_keyword_detector(elements, str, i, n):
        print(elements[i:-(len(elements) - len(str) - i)])
        if elements[i:-(len(elements) - len(str) - i)] == str:
            for j in range(1, len(str)):
                elements[i] += elements[i + j]
                del elements[i + j]
                n -= 1

    def gen_pif(self, element, value):
        self._programInternalForm.append((element, value))
