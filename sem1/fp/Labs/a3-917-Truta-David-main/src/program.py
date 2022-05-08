# Problem number 3 : Family Expenses
import datetime
from collections import Counter


# Iteration 1: add feature, insert feature
# Iteration 2: remove feature, list feature
# Iteration 3: unit testing, specifications, exceptions
# Iteration 4: unit testing, specifications, exceptions

# ================================================== Domain section =================================================

def create_expense(d, m, t):
    """
    Returns a dictionary formed by 3 elements: d,m,t
    :param d: day of a month(int)
    :param m: amount of money(int)
    :param t: type of expense(string)
    :return: a dictionary, representing an expense.
    Raise ValueError if d is not a number between 1 and 30
                     if m is not a number
                     if t is not a string formed by letters only
    """
    try:
        if isinstance(d, float) or isinstance(m, float):
            raise ValueError("ERROR!Day and amount of money should be natural numbers")
        d, m, t = int(d), int(m), str(t)
    except ValueError:
        raise ValueError("ERROR!The day and amount of money should be natural numbers!")
    if t.isalpha() is False:
        raise ValueError("ERROR!Category should be a single word!(ex: transport, others, etc.)")
    if (1 <= d <= 30) is False:
        raise ValueError("ERROR!Day of month should be in range [1,30]")
    return {'day': d, 'money': m, 'type': t}


def get_expense_day(exp):
    """
    Getter function, returns day of the expense exp.
    """
    return exp['day']


def get_expense_money(exp):
    """
    Getter function, returns money amount of the expense exp
    """
    return exp['money']


def get_expense_type(exp):
    """
    Getter function, returns category of the expense exp.
    """
    return exp['type']

# ============================================= Functionalities section ==============================================


def how_many_spaces(string):
    """
    Returns the number of spaces found in a string.
    :param string: a  string
    :return: how many spaces are in a string.
    """
    count = 0
    for i in string:
        if i.isspace():
            count += 1
    return count


def check_category(t):
    """
    This only raises an error if t is not a category.
    :param t: a string(category)
    :return:-
    RaisesValue if t is not a valid category.
    """
    ok = False
    str_categories = ''
    categories = ['housekeeping', 'food', 'transport', 'clothing', 'internet', 'others']
    for c in categories:
        if c == t:
            ok = True
            break
        str_categories += c + ' '
    if ok is False:
        raise ValueError('Not a valid category. Choose one of the following: ' + str_categories)


def add_expense(exp_data, params):
    """
    Functionality
    This adds an expense to the list of expenses(exp_data) with the current day of the month.
    :param exp_data: list of expenses.
    :param params: a string, expected to be of the form '10 others','15 transport'...
    :return:-
    Raises ValueError if arguments(params) are not of the right type, or not in the right order,
                      if not enough arguments or not separated by a space
    """
    if (' ' in params) is False:
        raise ValueError("ERROR!Not enough arguments OR arguments are not separated by one space!")
    m, t = params.split(' ', 1)
    # m should be the amount of money ,and t should be the category
    m.strip()
    t.strip()
    check_category(t)
    if m.isnumeric() is False or t.isalpha() is False:
        raise ValueError("ERROR!First argument should be a natural number and the second a word(category)")
    exp = create_expense(datetime.datetime.today().day, m, t)
    exp_data.append(exp)


def insert_expense(exp_data, params):
    """
    Functionality
    This adds an expense to the list of expenses(exp_data).
    :param exp_data: list of expenses
    :param params: a string expected to be of the form '10 4312 others', '30 124 food', etc.
    :return:-
    Raises ValueError if arguments(params) are not of the right type, or not in the right order,
                      if not enough arguments or not separated by a space.
    """
    if (how_many_spaces(params) >= 2) is False:
        raise ValueError("ERROR!Not enough arguments OR arguments are not separated by one space!")
    d, m, t = params.split(' ', 2)
    m.strip()
    t.strip()
    d.strip()
    check_category(t)
    if d.isnumeric() is False or m.isnumeric() is False:
        raise ValueError("ERROR!Arguments not of the right type, or not in the right order."
                         "\nTry something like:'insert 10 321 others'")
    exp = create_expense(d, m, t)
    exp_data.append(exp)


def remove_expense_day(exp_data, params):
    """
    Removes expense by day
    :param exp_data: exp_data: list of expenses(dictionaries)
    :param params: string expected to be of the form '1' or 'others' ot '1 to 3'
    :return:-
    Raises Value error if arguments not correct.
    """
    params = int(params)
    if (1 <= params <= 30) is False:
        raise ValueError("Number should be between 1 and 30 !")
    params, i, exists = int(params), 0, False
    while i < len(exp_data):
        if get_expense_day(exp_data[i]) == params:
            exp_data.remove(exp_data[i])
            i -= 1
            exists = True
        i += 1
    if exists is False:
        raise ValueError("There are no expenses on this day!")


def remove_expense_category(exp_data, params):
    """
    Removes expense by category
    :param exp_data: exp_data: list of expenses(dictionaries)
    :param params: string expected to be of the form '1' or 'others' ot '1 to 3'
    :return:-
    Raises Value error if arguments not correct.
    """
    check_category(params)
    i, exists = 0, False
    while i < len(exp_data):
        if get_expense_type(exp_data[i]) == params:
            exp_data.remove(exp_data[i])
            exists = True
            i -= 1
        i += 1
    if exists is False:
        raise ValueError("There are no expenses in this category!")


def remove_expense_days(exp_data, params):
    """
    Removes expense from a day to another: 'remove 1 to 5'
    :param exp_data: list of expenses(dictionaries)
    :param params: string expected to be of the form '1' or 'others' ot '1 to 3'
    :return:-
    Raises Value error if arguments not correct.
    """
    if ('to' in params) is False:
        raise ValueError("Incorrect arguments! Try something like: remove 1 to 10")
    params = params.replace(' ', '')
    n1, n2 = params.split('to', 1)
    if n1.isnumeric() is False or n2.isnumeric() is False:
        raise ValueError("Incorrect values! Try something like: remove 1 to 10")
    n1, n2 = int(n1), int(n2)
    if (1 <= n1 <= 30) is False or (1 <= n2 <= 30) is False or n2 < n1:
        raise ValueError("First and last number should be between 1 and 30 and the second one, bigger than "
                         "the first !")
    i = 0
    while i < len(exp_data):
        if n1 <= get_expense_day(exp_data[i]) <= n2:
            exp_data.remove(exp_data[i])
            i -= 1
        i += 1


def remove_expense(exp_data, params):
    """
    Functionality
    Removes an expense, based on arguments(params)
    :param exp_data: list of expenses(dictionaries)
    :param params: string expected to be of the form '1' or 'others' ot '1 to 3'
    Raises ValueError if numbers are not in range [1, 30]
                      if there is nothing to remove
                      if arguments are not correct
    :return:-
    """
    if params.isnumeric():
        # string params contains only numbers
        remove_expense_day(exp_data, params)
        # exp_data = [exp for exp in exp_data if get_expense_day(exp) != params]  # (just an experiment)
    elif params.isalpha():
        # string params contains only letters
        remove_expense_category(exp_data, params)
    else:
        remove_expense_days(exp_data, params)


def list_expense_separate(params):
    """
    Functionality
    Gets called only if command is of type: list others < 1000
    Separates params in two strings if it's arguments are valid.
    :param params: string expected to be of the form 'others < 700'
    :return: two strings( arguments from params)
    Raises ValueError if arguments are not correct
    """
    lo = ['<', '>', '=']
    count = Counter(params)
    # Counter returns a dictionary of characters and how many times they appear in a given string.
    # For example: Counter('<<>=') = {'<':2, '>':1, '=':1}
    if count['>'] > 1 or count['<'] > 1 or count['='] > 1:
        raise ValueError("There should be only one logical operator!")
    params = params.replace(' ', '')
    # the line above removes every space from params
    for Operator in lo:
        # Operator is '<', then '>', then '='
        if Operator in params:
            cat, cond = params.split(Operator, 1)
            # splits in two strings, category(cat) and condition(cond)
            if cond.isnumeric() is False:
                raise ValueError("Last argument should be a natural number!")
            check_category(cat)
            if Operator == '=':
                return cat, '=' + Operator + cond
            else:
                return cat, Operator + cond
    if params.isnumeric():
        raise ValueError("Cannot list by day or amount!")
    raise ValueError(
        "Logical operator not found! Try something like: 'list others < 450' ; L.o.:'>','=','<'")


def list_category(exp_data, params):
    """
    Returns a new list with category == params
    :param exp_data:List of expenses
    :param params: string expected to be of the form 'housekeeping'
    :return: new_list with the expenses that fit requirements
    Raises ValueError if it there are no expenses that fit requirements
    """
    check_category(params)
    exists = False
    new_list = []
    for exp in exp_data:
        if get_expense_type(exp) == params:
            new_list.append(exp)
            exists = True
    if exists is False:
        raise ValueError("No expense in this category!")
    return new_list


def list_category_cond(exp_data, params):
    """
    Returns a new list that fits the conditions
    :param params: string of type : ' transport < 15'
    :param exp_data:List of expenses
    :return: new_list with the expenses that fit requirements
    Raises ValueError if it there are no expenses that fit requirements
    """
    cat, cond = list_expense_separate(params)
    exists = False
    new_list = []
    for exp in exp_data:
        if get_expense_type(exp) == cat and eval(str(get_expense_money(exp)) + cond):
            new_list.append(exp)
            exists = True
    if exists is False:
        raise ValueError("No expense in this category with this conditions")
    return new_list


def default_expenses():
    # returns a list of expenses
    return [create_expense(3, 232, "housekeeping"), create_expense(24, 353, "food"),
            create_expense(30, 707, "internet"), create_expense(27, 13, "transport"),
            create_expense(17, 893, "clothing"), create_expense(30, 241, "housekeeping"),
            create_expense(8, 5, "transport"), create_expense(12, 1042, "others"),
            create_expense(19, 542, "others"), create_expense(23, 264, "food")]


def split_command(command):
    """
    :param command: string of type 'list transport < 10'
    :return: two strings, if there is a space in command, an empty string otherwise
    """
    com_split = command.split(' ', 1)
    return com_split[0].strip().lower(), com_split[1].strip().lower() if len(com_split) == 2 else ''

# ================================================== UI section =======================================================


def ui_help():
    print("\nCommands:\n"
          "list\t|\t list <category>\t|\t list <category> ['<'|'='|'>'] <value>"
          "\nadd <sum> <category>\t|\t insert <day> <sum> <category>"
          "\nremove <day>\t|\t remove <start day> to <end day>\t|\t remove <category>\n")


def ui_list_expense(exp_data, params):
    """
    UI Function
    Calls list_expense(), which splits params in two parts(cat, cond), and prints based on the arguments.
    :param exp_data: list of expenses
    :param params: string expected to be of the form 'housekeeping' ; 'others < 700'
    :return: -
    Raises ValueError if there is no expense to list
    """
    if params == '':
        # if here, then command was 'list'
        if len(exp_data) == 0:
            raise ValueError("List is empty!")
        list_data = exp_data
    elif params.isalpha():
        # here, only if params is a category.
        list_data = list_category(exp_data, params)
    else:
        # here if neither of the above were true
        list_data = list_category_cond(exp_data, params)
    c = 1
    for expense in list_data:
        # eval turns string into a condition you can use in an if statement
        # cat = category (from params) , cond = condition, should look like: '> 10'
        print("Expense", c, ":  ", "day:", get_expense_day(expense), "| amount of money:",
              get_expense_money(expense), "| expense type:", get_expense_type(expense))
        c += 1


def run_command_ui():
    """
    Main UI function
    Calls all the other ui functions
    :return:-
    """
    test_init()
    print("To see the available commands type 'help' and hit enter.")
    command = ''
    com_dictionary = {'add': add_expense, 'insert': insert_expense, 'remove': remove_expense,
                      'list': ui_list_expense}
    exp_data = default_expenses()
    while command != 'exit':
        command = input('command >').strip().lower()
        com_word, com_param = split_command(command)
        if command == 'exit':
            break
        elif command == 'help':
            ui_help()
        elif com_word in com_dictionary:
            try:
                com_dictionary[com_word](exp_data, com_param)
            except ValueError as ve:
                print(ve)
        else:
            print("Enter a relevant command!")

# ================================================== Test functions ===================================================


def test_create_expense():
    exp = create_expense(20, 1234, "housekeeping")
    assert get_expense_day(exp) == 20 and get_expense_money(exp) == 1234 and get_expense_type(exp) == 'housekeeping'
    try:
        create_expense(40, 4213, "others")
        assert False
    except ValueError:
        assert True
    try:
        create_expense("a", "b", "123")
        assert False
    except ValueError:
        assert True
    try:
        create_expense(1.3, 1.2, "others")
        assert False
    except ValueError:
        assert True
    try:
        create_expense("1.3", "1.2", "others")
        assert False
    except ValueError:
        assert True
    try:
        create_expense("10", "10", "others2")
        assert False
    except ValueError:
        assert True


def test_add_expense(test_list):
    add_expense(test_list, "421 food")
    assert len(test_list) == 11
    try:
        add_expense(test_list, "")
        assert False
    except ValueError:
        assert True
    try:
        add_expense(test_list, "others 10")
        assert False
    except ValueError:
        assert True


def test_insert_expense(test_list):
    insert_expense(test_list, "4 123 others")
    assert len(test_list) == 12
    try:
        insert_expense(test_list, "12 10")
        assert False
    except ValueError:
        assert True
    try:
        insert_expense(test_list, "10 others 10")
        assert False
    except ValueError:
        assert True


def test_remove_expense(test_list):
    remove_expense(test_list, "4")
    assert len(test_list) == 11
    remove_expense(test_list, "housekeeping")
    assert len(test_list) == 9
    remove_expense(test_list, "1 to 12")
    assert len(test_list) == 7
    try:
        remove_expense(test_list, "4")
        assert False
    except ValueError:
        assert True
    try:
        remove_expense(test_list, "39")
        assert False
    except ValueError:
        assert True
    try:
        remove_expense(test_list, "39")
        assert False
    except ValueError:
        assert True
    try:
        remove_expense(test_list, "feaj124oa")
        assert False
    except ValueError:
        assert True
    try:
        remove_expense(test_list, "10 to 4")
        assert False
    except ValueError:
        assert True
    try:
        remove_expense(test_list, "a to 4")
        assert False
    except ValueError:
        assert True


def test_list_category(test_list):
    new_list = list_category(test_list, "others")
    assert len(new_list) == 2
    try:
        list_category(test_list, 'oth')
        assert False
    except ValueError:
        assert True
    try:
        list_category(test_list, '20')
        assert False
    except ValueError:
        assert True


def test_list_expense_separate():
    cat, cond = list_expense_separate("others = 542")
    assert cat == 'others' and cond == '==542'
    try:
        list_expense_separate("others >= 542")
        assert False
    except ValueError:
        assert True
    try:
        list_expense_separate("542 = others")
        assert False
    except ValueError:
        assert True
    try:
        list_expense_separate("others")
        assert False
    except ValueError:
        assert True


def test_how_many_spaces():
    string = ' b  a '
    assert 4 == how_many_spaces(string)


def test_check_category():
    check_category('transport')
    try:
        check_category('oders')
        assert False
    except ValueError:
        assert True
    try:
        check_category('123category')
        assert False
    except ValueError:
        assert True
    try:
        check_category('transport')
    except ValueError:
        assert False


def test_init():
    test_how_many_spaces()
    test_check_category()
    test_create_expense()
    test_list = default_expenses()
    test_list_category(test_list)
    test_list_expense_separate()
    test_add_expense(test_list)
    test_insert_expense(test_list)
    test_remove_expense(test_list)


# Main function call ==================================================================================================
run_command_ui()
