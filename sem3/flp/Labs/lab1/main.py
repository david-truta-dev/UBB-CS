class Node:
    def __init__(self, n):
        self.value = n
        self.next = None


class List:
    def __init__(self):
        self.first = None

    def create(self):
        list = List()
        list.first = self.createRec()
        return list

    def createRec(self):
        n = int(input("Li ="))
        if n == 0:
            return None
        else:
            node = Node(n)
            node.next = self.createRec()
            return node

    def print(self):
        self.printRec(self.first)

    def printRec(self, node):
        if node is not None:
            print(node.value, end=" ")
            self.printRec(node.next)
        else:
            print()


# R1: 3


# a. Check if a list is a set.

# A list is a set if it has unique elements, so we need the following functions:
#
# checkElem([l1,l2,...ln], elem) = false, n = 0
#                                   true, elem = l1
#                                   checkElem([l2,...ln], elem), otherwise

# we use checkSetRec([l1,l2,...ln]) = true, n = 0
#                                     false, checkElem([l2,...ln], l1) = true
#                                     checkSetRec([l2,l3,...,ln]), otherwise

# checkSet([l1,l2,...ln]) = true, checkSet([l1,l2,...ln]) = true
#                           false, checkSet([l1,l2,...ln]) = false

def checkElem(node, elem):
    if node is None:
        return None
    if elem == node.value:
        return True
    return checkElem(node.next, elem)


def checkSetRec(node):
    if node is None:
        return True
    if checkElem(node.next, node.value) is True:
        return False
    return checkSetRec(node.next)


def checkSet(lst):
    if checkSetRec(lst.first) is True:
        return True
    else:
        return False


def testR13a():
    list = List().create()
    list.print()
    if checkSet(list) is True:
        print("IT IS A SET")
    else:
        print("IT'S NOT A SET")


# b. Determine the number of distinct elements from a list

# For this we can use the previous function, checkElem, and we can subtract 1 from the total number every time
# we find an occurrence so we get the number of distinct elems.
# checkElem([l1,l2,...ln], elem) = false, n = 0
#                         true, elem = l1
#                         checkElem(l2, l3, ...,ln), otherwise

# distinctElemsRec([l1,l2,...ln]) = 0, length = 0
#                                   -1 + distinctElemsRec([l2,l3,...,ln]), checkElem([l2,..ln], l1) = True
#                                   1 + distinctElemsRec([l2,l3,...,ln]), checkElem([l2,..ln], l1) = False

# distinctElems([l1,l2,...ln]) = 0, length = 0
#                                distinctElemsRec([l2,...ln]), otherwise


def distinctElemsRec(node):
    if node is None:
        return 0
    if checkElem(node.next, node.value):
        return -1 +distinctElemsRec(node.next)
    else:
        return 1 + distinctElemsRec(node.next)


def distinctElems(list):
    if list.first is None:
        return 0
    return distinctElemsRec(list.first)


def testR13b():
    list = List().create()
    list.print()
    print("Number of distinct elems :", distinctElems(list))


if __name__ == '__main__':
    #testR13a()
    testR13b()

