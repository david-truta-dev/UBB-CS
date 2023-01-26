# lab2
from dataclasses import dataclass


class HashTableST():
    """
        https://github.com/Andrei-Vasil/FCLD.git
        Hash Table that is supposed to store identifiers and constants.
        _size:      number of elements in the hash table
        cap:        capacity of the hash table
        hashtable:  list of lists where the elements will be stored
                    usually, the lists in the second degree of depth will have 1-2 elements at max
        p: constant for the hash function
    """
    p = 31

    def __init__(self):
        self._size = 0
        self.cap = 21
        self.hashtable = [[] for _ in range(self.cap)]

    @property
    def size(self) -> int:
        return self._size

    @size.setter
    def size(self, value: int) -> None:
        self._size = value
        # if self.size >= self.cap // 2:
        #     self.scaleup()
    
    def hashfnc(self, k: any) -> int:
        """
            String hashing algorithm. Int constants will be converted to string
            Credits to: https://cp-algorithms.com/string/string-hashing.html
        """
        k = str(k)
        hashval = 0
        for i, c in enumerate(k):
            hashval += (ord(c) - ord('a') + 1) * (HashTableST.p ** i)
            hashval %= self.cap
        return hashval

    def scaleup(self) -> None:
        """
            When the size of the HT will be more than half of its capacity, the capacity of the HT will double in size
            and all values will be reassigned on the newly created hash table
        """
        self.cap *= 2
        new_hashtable = [[] for _ in range(self.cap)]
        self.reassign(new_hashtable)

    def reassign(self, new_hashtable: list) -> None:
        """
            Reassign values so that they fit the newly created HT
        """
        for vals in self.hashtable:
            for val in vals:
                new_hashtable[self.hashfnc(val)].append(val)
        self.hashtable = new_hashtable

    def add(self, k: any) -> None:
        """
            Add a value to the HT
        """
        hash_pos = self.hashfnc(k)
        if not self.exists(k):
            self.size += 1
            self.hashtable[hash_pos].append(k)
        return (hash_pos, self.hashtable[hash_pos].index(k))

    def remove(self, k: any) -> None:
        """
            Removes a value from the HT
        """
        self.size -= 1
        vals = self.hashtable[self.hashfnc(k)]
        for i, val in enumerate(vals):
            if val == k:
                vals[i] = vals[-1]
                vals.pop()
                break
    
    def exists(self, k: any) -> bool:
        """
            Returns whether a value exists in the HT
        """
        for val in self.hashtable[self.hashfnc(k)]:
            if val == k:
                return True
        return False

    def save_to_file(self, path):
        with open(path, 'w') as file:
            file.write("ST\n")
            for hashnudal in self.hashtable:
                file.write(str(hashnudal) + "\n")

    def __str__(self):
        return str(self.hashtable)
