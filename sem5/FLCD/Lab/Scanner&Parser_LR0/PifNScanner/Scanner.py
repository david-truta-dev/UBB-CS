import re
from HashTableST import HashTableST
from PIF import PIF

class Scanner:
    def __init__(self):
        self.pif_file_path = "data/pif.txt"
        self.const_st_file_path = "data/const_st.txt"
        self.id_st_file_path = "data/id_st.txt"

        self.identifiers = HashTableST()
        self.constants = HashTableST()
        self.pif = PIF()

        self.reserved_expressions = re.compile('^(if|else|while|print|int|bool|string|print|read)$')
        self.number = re.compile('^((-|\+){,1}[1-9]+[0-9]*)|0$')
        self.string = re.compile('^(\'|\")[ a-zA-Z.;:?!]*(\'|\")$')
        self.identifier = re.compile('^[a-zA-Z]+[a-zA-Z0-9_-]*$')
        self.operator = re.compile('^(\+|-|/|\*|=|==|!=|<|>|<=|>=|&&|\|\|)$')
        self.deliminator = re.compile('^(;|\{|\}| |\n|,|\(|\))$')
        self.comment = re.compile('^//$')

    def read_file(self, input_path: str):
        file = open(input_path, 'r')
        
        expression = ''
        is_string = False
        while file:
            byte = file.read(1)
            
            if byte == "\"":
                is_string = not is_string

            if byte == '':
                break
            if self.comment.match(expression + byte):
                file.readline()
                expression = ''
            elif is_string and byte == ' ':
                expression += byte
            elif self.deliminator.match(byte):
                if expression == '':
                    continue
                elif self.reserved_expressions.match(expression) is not None:
                    self.pif.add_reserved(expression)
                elif self.number.match(expression) is not None:
                    pos = self.constants.add(expression)
                    self.pif.add_constant(pos)  # add const
                    print(pos, expression, "number")
                elif self.string.match(expression) is not None:
                    pos = self.constants.add(expression)
                    self.pif.add_constant(pos)  # add const
                    print(pos, expression, "string")
                elif self.identifier.match(expression) is not None:
                    pos = self.identifiers.add(expression)
                    self.pif.add_identifier(pos)  # add id
                elif self.operator.match(expression) is not None:
                    self.pif.add_reserved(expression)
                else:
                    print(expression)
                    print('lexical error')
                    exit(1)
                # print(expression + "\n")
                expression = ''

                if byte != ' ' and byte != '\n':
                    self.pif.add_reserved(byte)
            else:
                expression += byte
        # print(self.constants.hashtable)
        # print(self.pif)
        self.pif.save_to_file(self.pif_file_path)
        self.constants.save_to_file(self.const_st_file_path)
        self.identifiers.save_to_file(self.id_st_file_path)


if __name__ == "__main__":
    Scanner().read_file('input/p1.in')
