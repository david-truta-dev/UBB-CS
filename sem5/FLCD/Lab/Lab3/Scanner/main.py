from symbol_table import SymbolTable

if __name__ == '__main__':
    symTbl = SymbolTable()

    symTbl.add("un element")
    symTbl.add("al doilea element")

    print(symTbl.add("un element"))
    print(symTbl.get("un element"))
    print(symTbl.get("al doilea element"))


