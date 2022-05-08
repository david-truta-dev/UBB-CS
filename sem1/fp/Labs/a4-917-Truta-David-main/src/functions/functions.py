"""
Functions that implement program features. They should call each other, or other functions from the domain
"""
from collections import Counter
from datetime import datetime
from src.domain.entity import get_expense_day, create_expense, get_expense_type, get_expense_money, get_daily_expense


def default_expenses():
    # Returns a list of expenses
    return [create_expense(3, 232, "housekeeping"), create_expense(24, 353, "food"),
            create_expense(30, 707, "internet"), create_expense(27, 13, "transport"),
            create_expense(17, 893, "clothing"), create_expense(30, 241, "housekeeping"),
            create_expense(8, 5, "transport"), create_expense(12, 1042, "others"),
            create_expense(19, 542, "others"), create_expense(23, 264, "food")]


def split_command(command):
    """
    :param command: string of type 'list transport < 10'
    :return: two strings('list', 'transport < 10'), if there is a space in command, an empty string otherwise
    """
    com_split = command.split(' ', 1)
    if len(com_split) == 2 and com_split[1].strip().lower() == 'day' and com_split[0].strip().lower() == 'max':
        # if command is 'max day', then it returns 'max day',''
        return com_split[0]+' '+com_split[1], ''
    return com_split[0].strip().lower(), com_split[1].strip().lower() if len(com_split) == 2 else ''


def how_many_spaces(string):
    """
    Returns the number of spaces found in a string
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
    Raises ValueError if: arguments(params) are not of the right type or not in the right order,
                          not enough arguments or not separated by a space
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
    exp = create_expense(datetime.today().day, m, t)
    exp_data.append(exp)


def insert_expense(exp_data, params):
    """
    Functionality
    This adds an expense to the list of expenses(exp_data).
    :param exp_data: list of expenses
    :param params: a string expected to be of the form '10 4312 others', '30 124 food', etc.
    Raises ValueError if: arguments(params) are not of the right type or not in the right order,
                          not enough arguments or not separated by a space.
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
    i, exists = 0, False
    while i < len(exp_data):
        if n1 <= get_expense_day(exp_data[i]) <= n2:
            exp_data.remove(exp_data[i])
            i -= 1
            exists = True
        i += 1
    if exists is False:
        raise ValueError("There are no expenses to remove in this category!")

def remove_expense(exp_data, params):
    """
    Functionality
    Removes an expense, based on arguments(params)
    Calles all the other remove functions from above.
    :param exp_data: list of expenses(dictionaries)
    :param params: string expected to be of the form '1' or 'others' ot '1 to 3'
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


def arguments_split_list_filter(params):
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


def list_category_cond(exp_data, params):
    """
    Returns a new list that fits the conditions
    :param params: string of type : ' transport < 15'
    :param exp_data:List of expenses
    :return: new_list with the expenses that fit requirements
    Raises ValueError if: it there are no expenses that fit requirements, list empty
    """
    if len(exp_data) == 0:
        raise ValueError("List is empty!")
    cat, cond = arguments_split_list_filter(params)
    exists = False
    new_list = []
    for exp in exp_data:
        if get_expense_type(exp) == cat and eval(str(get_expense_money(exp)) + cond):
            # eval turns string into a condition you can use in an if statement
            # cat = category (from params) , cond = condition, should look like: '> 10'
            new_list.append(exp)
            exists = True
    if exists is False:
        raise ValueError("No expense in this category with this conditions")
    return new_list


def list_category(exp_data, params):
    """
    Returns a new list with category == params
    :param exp_data:List of expenses
    :param params: string expected to be a category
    :return: new_list with the expenses that fit requirements
    Raises ValueError if it there are no expenses that fit requirements, list empty
    """
    if len(exp_data) == 0:
        raise ValueError("List is empty!")
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


def list_all(exp_data):
    """
    Returns exact same list, or raises calue error.
    :param exp_data: list of expenses
    :return: list of expenses
    Raises ValueError if list is empty
    """
    if len(exp_data) == 0:
        raise ValueError("List is empty!")
    return exp_data


def list_expenses(exp_data, params):
    """
    Calls all the other list functions from above, depending of params, which is expected to be of type:
    'list', 'list others', 'list transport > 15'
    :param exp_data: list of expenses
    :param params: string(parameters)
    :return: the list which shold be printed
    """
    if params == '':
        # if here, then command was 'list'
        return list_all(exp_data)
    elif params.isalpha():
        # here, only if params is a category.
        return list_category(exp_data, params)
    else:
        # here if neither of the above were true
        return list_category_cond(exp_data, params)


def get_list_elements(list):
    """
    Returns a list with the elements of list.
    if I did something like new_list = list, new_list would just be a copy of list with the same reference,
    so if i do something to list, the modifications also appear in new_list.
    This function returns a shallow copy of the list
    :param list:  a list
    :return: a new list with elemnts of list
    """
    new_list = []
    for data in list:
        new_list.append(data)
    return new_list


def undo(exp_data, history):
    """
    Undeoes last operation that modified the expenses(exp_data).
    Can be called until there are no more operations to undo.
    :param exp_data: list of expenses
    :param history: list of previous values from exp_data
    Raises IndexError if there are no more operations to undo
    """
    if len(history) == 0:
        raise IndexError("No more undoes!")
    exp_data.clear()
    for exp in history[len(history)-1]:
        exp_data.append(dict(exp))
    history.pop()


def sum_expense(exp_data, params):
    """
    Computes and returns the total expense for a given category.
    :param exp_data: list of expenses
    :param params: in this case, it should be the category
    :return: total expense for a given category.
    Raises ValueError if: category not valid, there are no expenses with category required
    """
    exp_sum, exists = 0, False
    check_category(params)
    for expense in exp_data:
        if params == get_expense_type(expense):
            exp_sum += get_expense_money(expense)
            exists = True
    if exists is False:
        raise ValueError("There are no expenses in this category!")
    return exp_sum


def total_expenses_day(exp_data, day):
    """
    Computes and returns the total expenses in a day given as a parameter
    :param exp_data: list of expenses
    :param day: int in range[1, 30]
    :return: total expenses in a day
    """
    sum = 0
    for expense in exp_data:
        if get_expense_day(expense) == day:
            sum += get_expense_money(expense)
    return sum


def day_max_exp(exp_data,params):
    """
    Computes and returns the day with biggest expenses, and the total of the expenses.
    :param exp_data: List of expenses
    :param params: an empty string(it is not used here)
    :return: the day with biggest expenses, and the total value of the expenses
    Raises ValueError if list is empty
    """
    if len(exp_data) == 0:
        raise ValueError("There are no expenses!")
    days, max_sum = [], 0
    for d in range(1,31):
        sum = total_expenses_day(exp_data,d)
        if sum > max_sum:
            # if it found a day with a bigger total expense, it emptys the list from before
            days.clear()
            days.append(d)
            max_sum = sum
        elif sum == max_sum:
            # if it found a day with an equal total expense, it adds to the day to the list
            days.append(d)
    return days, max_sum


def filter_exp_category(exp_data, params):
    """
    Keeps in exp_data only the expenses that fit given category
    :param exp_data: list of expenses
    :param params: category
    Raises ValueError if params is not a valid category or there is no expense for given category
    """
    check_category(params)
    new_exp_data = list(filter(lambda exp: get_expense_type(exp) == params, exp_data))
    if len(new_exp_data) == 0:
        raise ValueError('There are no expenses in this category!')
    exp_data.clear()
    for exp in new_exp_data:
        exp_data.append(exp)


def filter_with_condition(exp_data, params):
    """
    Keeps in exp_data only the expenses that fit given category and fit given condtion
    :param exp_data: list of expenses
    :param params: category and condition (string)
    Raises ValueError if params is not a valid category or if no expense in given category
    """
    cat, cond = arguments_split_list_filter(params)
    # cat is going to be the category, cond is going to be the condition
    check_category(cat)
    new_exp_data = list(filter(lambda exp: get_expense_type(exp) == cat
                                           and eval('get_expense_money(exp)' + cond), exp_data))
    # eval turns string into a condition
    if len(new_exp_data) == 0:
        raise ValueError('There are no expenses in this category!')
    exp_data.clear()
    for exp in new_exp_data:
        exp_data.append(exp)


def filter_expenses(exp_data, params):
    """
    Calls the other filter functions from above, depending on params
    :param exp_data: list of expenses
    :param params: string of type 'others' 'others > 10'
    """
    if params.isalpha():
        filter_exp_category(exp_data, params)
    else:
        filter_with_condition(exp_data,params)


def sort_daily_exp_amount(exp_data):
    """
    Computes and returns a list of total daily expenses sorted by amount spent in that day
    :param exp_data: list of expenses
    :return: list of tuples of type : (day, total amount spent in that day)
    Raises ValueError if list is empty
    """
    if len(exp_data) == 0:
        raise ValueError('List is empty!')
    daily_exp = []
    for d in range(1,31):
        sum = total_expenses_day(exp_data,d)
        if sum > 0:
            daily_exp.append((d, sum))
    daily_exp.sort(key = get_daily_expense)
    return daily_exp


def total_expenses_category(exp_data, day, categ):
    """
    Computes and returns the total expenses in a day given as a parameter(day) from a given category(categ)
    :param exp_data: list of expenses
    :param day: int in range[1, 30]
    :return: total expenses in a day from a given category
    """
    sum = 0
    for expense in exp_data:
        if get_expense_day(expense) == day and get_expense_type(expense) == categ:
            sum += get_expense_money(expense)
    return sum


def sort_daily_exp_category_amount(exp_data, params):
    """
    Computes and returns a list of daily expenses from a category sorted by amount spent in that day
    :param exp_data: list of expenses
    :param params: a category
    :return: list of tuples of type : (day, total amount spent in that day)
    Raises ValueError if list is empty
    """
    if len(exp_data) == 0:
        raise ValueError('List is empty!')
    daily_exp = []
    for d in range(1, 31):
        sum = total_expenses_category(exp_data, d, params)
        if sum > 0:
            daily_exp.append((d, sum))
    daily_exp.sort(key = get_daily_expense)
    if len(daily_exp) == 0:
        raise ValueError('No expenses in this category!')
    return daily_exp

def sort_expenses(exp_data, params):
    """
    Calls the other sort functions from above
    :param exp_data: list of expenses
    :param params: string ('day' or a valid category)
    :return: list of tuples of type : (day, total amount spent in that day)
    Raises ValueError if params is not neither 'day' or a valid category
    """
    if params == 'day':
        return sort_daily_exp_amount(exp_data)
    else:
        check_category(params)
        return sort_daily_exp_category_amount(exp_data, params)
