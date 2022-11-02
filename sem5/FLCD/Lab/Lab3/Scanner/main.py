from scanner import Scanner

if __name__ == '__main__':
    with open('p1.txt', 'r') as file:
        program = file.read()
    scanner = Scanner(program)
