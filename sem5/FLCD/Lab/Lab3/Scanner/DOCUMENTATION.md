# Scanner Documentation

## Scanner Implementation:
#### The scanner has the text of the program as a String (file_string), a SymbolTable that will be used for both constants and identifiers, the program internal form which we will construct, and the tokens and operators of the language.
```
class Scanner:
    def __init__(self, file_string):
        self._file = file_string
        self._symbolTable = SymbolTable()
        self._programInternalForm = []
        self._tokens = [...]
        self._operators = [...]
```


#### The scan method of the Scanner is run when a scanner is instantiated. It goes through each element, on each line anc checks for tokens, adding them to the PIF in order. In case of identifiers or constants the scan method also puts them in the SymbolTable. The scan method also calls a helper function to write the ST and PIF to .out files
 ```
 def scan(self):
        elements = re.split('[\n]', self._file)
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
                        constant_type = self.detect_constant(token)
                        if constant_type != ConstantType.NOTHING:
                            if constant_type == ConstantType.NUMBER:
                                self.gen_pif(PifElement.CONSTANT.value, self._symbolTable.add(int(token)))
                            elif constant_type == ConstantType.CHAR:
                                self.gen_pif(PifElement.CONSTANT.value, self._symbolTable.add(token))
                            else:
                                self.gen_pif(PifElement.CONSTANT.value, self._symbolTable.add(token))
                        else:
                            raise ValueError(
                                'Lexical Error on line ' + str(elements.index(element)) + ' at token ' + token)
        print(self._symbolTable)
        print((str(self._programInternalForm).replace("),", "),\n")))
        self.write_files(self._symbolTable, self._programInternalForm)
```

#### The detect_tokens takes as input a line of the program and it returns a list of all the tokens.
```
 def detect_tokens(self, string):
        line_data = re.split('("[^_a-zA-Z0-9\"\']")|([^_a-zA-Z0-9\"\'])', string)
        elements = [el for el in line_data if el is not None and el != '' and el != ' ']
        n = len(elements) - 1
        for i in range(n):
            if i > n:
                break
            if elements[i] == '<' or elements[i] == '>' or elements[i] == '=' or elements[i] == '!':
                if elements[i + 1] == '=':
                    elements[i] += elements[i + 1]
                    del elements[i + 1]
                    n -= 1
                    continue

            if elements[i] == '+' or elements[i] == '-':
                if i == 0 or elements[i - 1] in self._operators:
                    elements[i + 1] = elements[i] + elements[i + 1]
                    del elements[i]
                    n -= 1
                    continue

        return elements
```
## Program Internal Form (PIF):
####The program internal form is a list of tuples. Each tuple contains an element and it's value. In case the element is a constant or an identifier, the value is its position in the SymbolTable.

Example: <br> [('BEGIN', 0), ('identifier', 12), ('=', 0), ('constant', 13), (';', 0), ('END', 0)]

## Symbol Table (ST):
#### Keeps track of all the identifiers and constants in the program.

Hash Function:
- INPUT: element(any), index(int)
- OUTPUT: hash(int)
- uses the built-in python hash function, which creates a unique int for each value. 
- the hash is computed using an index and an element.

Add method:
- INPUT: element(any)
- OUTPUT: element(any) OR position(int)
- in case the element was already added the function will return the element, otherwise it will iterate over the 
available positions, calling the hash function and trying to insert it.
- in case of collision the element the size will increase and the element will pe placed on the next available index.

Get Method:
- INPUT: element(any)
- OUTPUT: index(int)
- returns -1 in case the element doesn't exist, returns the position in the SymbolTable
