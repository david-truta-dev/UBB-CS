"""
Domain file includes code for entity management
entity = number, transaction, expense etc.
"""


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
# ==================Others entities===========================================================


def get_daily_expense(exp):
    """
    Getter function for daily expense(used for sort functions). Returns the amount spent in a day from a tuple.
    """
    return exp[1]
