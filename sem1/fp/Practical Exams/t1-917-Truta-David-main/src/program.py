# ========================================= Functionalities ====================================================

def add(dict, args):
    key, rest = args.split('(', 1)
    arg = rest.split(',', 100)
    larg, rest = arg[len(arg) - 1].split(')', 1)
    arg.pop(len(arg) - 1)
    arg += larg

    func = rest.replace('=', '')

    final = key + '('
    for el in arg:
        final += el + ','

    final += ')' + ': return ' + func
    dict[key] = final


def split_command(command):
    return command.split(' ', 1)


# ================================================ UI ==========================================================

def ui_list(dict, args):
    print(dict[args])


def ui_eval(dict, args):
    pass


def ui_add(dict, args):
    res = add(dict, args)


def run_console():
    dict = {}
    com_dict = {'add': ui_add, 'list': ui_list, 'eval': ui_eval}
    while True:
        command = input('Command > ')
        com_word, args = split_command(command)
        if command == 'x':
            break
        else:
            try:
                com_dict[com_word](dict, args)
            except Exception as e:
                print(e)


run_console()
