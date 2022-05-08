

class IterableDataStructure:

    def __init__(self):
        self._entities = {}

    def __setitem__(self, key, value):
        self._entities[key] = value

    def __getitem__(self, key):
        return self._entities[key]

    def __delitem__(self, key):
        self._entities.pop(key)

    def __iter__(self):
        self.key_index = 0
        self.keys = list(self._entities.keys())
        return self

    def __next__(self):
        if len(self.keys) == self.key_index:
            raise StopIteration()
        self.key_index += 1
        return self._entities[self.keys[self.key_index - 1]]

    def __len__(self):
        return len(self._entities)

    def pop(self, key):
        return self._entities.pop(key)

    def values(self):
        return self._entities.values()

    def keys(self):
        return self._entities.keys()

    def clear(self):
        self._entities.clear()

    @staticmethod
    def gnome_sort(list, fct, reversed=False):
        index = 0
        if len(list) < 2:
            return list
        while index < len(list):
            if index == 0:
                index = index + 1
            if reversed is False:
                if fct(list[index]) >= fct(list[index - 1]):
                    index = index + 1
                else:
                    list[index], list[index - 1] = list[index - 1], list[index]
                    index = index - 1
            else:
                if fct(list[index]) <= fct(list[index - 1]):
                    index = index + 1
                else:
                    list[index], list[index - 1] = list[index - 1], list[index]
                    index = index - 1
        return list

    @staticmethod
    def filter(list, fct, *args):
        res = []
        for element in list:
            if fct(element, *args) is True:
                res.append(element)
        if not res:
            raise ValueError('No elements have been found!')
        return res
