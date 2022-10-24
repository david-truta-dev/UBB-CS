class SymbolTable:
    def __init__(self, initial_capacity=16):
        self._capacity = initial_capacity
        self._size = 0
        self._elements = ["[_/\_( - o -)_/\_]" for i in range(self._capacity)]

    def hash_function(self, element, index):
        return (hash(element) % self._capacity + index * (
                hash(element) * hash(element) % self._capacity)) % self._capacity

    def add(self, element):
        if element in self._elements:
            return self.get(element)
        for trial in range(self._capacity):
            current_position = self.hash_function(element, trial)
            if self._elements[current_position] == "[_/\_( - o -)_/\_]":
                self._elements[current_position] = element
                self._size += 1
                return current_position

    def get(self, element):
        for trial in range(self._capacity):
            current_position = self.hash_function(element, trial)
            if self._elements[current_position] == element:
                return current_position
        return -1

    def __str__(self):
        res = ""
        for i in range(len(self._elements)):
            if self._elements[i] != "[_/\_( - o -)_/\_]":
                res += str(i) + ' : ' + str(self._elements[i]) + '\n'
            else:
                res += str(i) + ' : -\n'
        return res
