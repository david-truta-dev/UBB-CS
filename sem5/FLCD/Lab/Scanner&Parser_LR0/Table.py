from Row import Row


class Table:
    def __init__(self):
        self.tableRow: dict[int, Row] = {}

    def __str__(self) -> str:
        s = ''
        for (rowIndex, row) in sorted(self.tableRow.items(), key=lambda x: (x[0])):
            s += f'{rowIndex}: {str(row)}\n'
        return s
