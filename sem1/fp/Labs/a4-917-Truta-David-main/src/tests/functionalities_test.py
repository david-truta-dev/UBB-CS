"""
The test functions are put in here. They test the complex functionalities.
"""
from src.domain.entity import create_expense, get_expense_day, get_expense_money, get_expense_type
from src.functions.functions import insert_expense, remove_expense, how_many_spaces, check_category, \
    default_expenses, add_expense, arguments_split_list_filter, list_expenses, get_list_elements, undo, sum_expense, \
    total_expenses_day, day_max_exp, filter_expenses, total_expenses_category, sort_expenses


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
    try:
        insert_expense(test_list, "123 1000 others")
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
        # There is no expense on day 4
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


def test_list_expenses(test_list):
    new_list = list_expenses(test_list, "others")
    assert len(new_list) == 2
    new_list = list_expenses(test_list, "")
    assert len(new_list) == 10
    new_list = list_expenses(test_list, "others = 542")
    assert len(new_list) == 1
    try:
        list_expenses(test_list, 'othgas')
        assert False
    except ValueError:
        assert True
    try:
        list_expenses(test_list, '20')
        assert False
    except ValueError:
        assert True


def test_arguments_split_list_filter():
    cat, cond = arguments_split_list_filter("others = 542")
    assert cat == 'others' and cond == '==542'
    cat, cond = arguments_split_list_filter("food > 231")
    assert cat == 'food' and cond == '>231'
    cat, cond = arguments_split_list_filter("transport < 15")
    assert cat == 'transport' and cond == '<15'
    try:
        arguments_split_list_filter("others >= 542")
        assert False
    except ValueError:
        assert True
    try:
        arguments_split_list_filter("542 = others")
        assert False
    except ValueError:
        assert True
    try:
        arguments_split_list_filter("12")
        assert False
    except ValueError:
        assert True


def test_get_list_elements(test_list):
    new_test_list = get_list_elements(test_list)
    assert id(new_test_list) != id(test_list)
    for i in range(len(new_test_list)):
        if new_test_list[i] != test_list[i]:
            assert False


def test_undo(test_list):
    # undo where theres is nothing to undo
    history = []
    try:
        undo(test_list, history)
        assert False
    except IndexError:
        assert True
    # undo operations
    history.append(get_list_elements(test_list))
    insert_expense(test_list, '1 5000 housekeeping')
    history.append(get_list_elements(test_list))
    add_expense(test_list, '300 food')
    history.append(get_list_elements(test_list))
    remove_expense(test_list, '1')
    # first undo
    undo(test_list, history)
    assert len(test_list) == 12
    # second undo
    undo(test_list, history)
    assert len(test_list) == 11
    # third undo
    undo(test_list, history)
    assert len(test_list) == 10


def test_sum_expense(test_list):
    sum_e = sum_expense(test_list, 'others')
    assert sum_e == 1584
    sum_e = sum_expense(test_list, 'clothing')
    assert sum_e == 893
    remove_expense(test_list, 'clothing')
    try:
        sum_expense(test_list, 'clothing')
        assert False
    except ValueError:
        assert True


def test_total_expenses_day(test_list):
    te = total_expenses_day(test_list, 24)
    assert te == 353
    insert_expense(test_list, '24 307 others')
    te = total_expenses_day(test_list, 24)
    assert te == 660
    te = total_expenses_day(test_list, 3)
    assert te == 232


def test_day_max_exp(test_list):
    days, amount = day_max_exp(test_list, '')
    assert 12 in days and amount == 1042 and len(days) == 1
    insert_expense(test_list, '1 1042 others')
    days, amount = day_max_exp(test_list, '')
    assert 12 in days and 1 in days and amount == 1042 and len(days) == 2
    insert_expense(test_list, '3 2000 housekeeping')
    days, amount = day_max_exp(test_list, '')
    assert 3 in days and amount == 2232 and len(days) == 1
    try:
        day_max_exp([], '')
        assert False
    except ValueError:
        assert True


def test_filter_expenses(test_list):
    try:
        filter_expenses(test_list, 'ajhwfia')
        assert False
    except ValueError:
        assert True
    try:
        filter_expenses(test_list, 'others <= 100')
        assert False
    except ValueError:
        assert True
    insert_expense(test_list, '10 50 transport')
    filter_expenses(test_list, 'transport < 20')
    assert len(test_list) == 2
    insert_expense(test_list, '10 3 transport')
    filter_expenses(test_list, 'transport > 4')
    assert len(test_list) == 2
    filter_expenses(test_list, 'transport = 5')
    assert len(test_list) == 1
    test_list.clear()
    for exp in default_expenses():
        test_list.append(exp)
    filter_expenses(test_list, 'others')
    assert len(test_list) == 2
    test_list.clear()
    for exp in default_expenses():
        test_list.append(exp)


def test_total_expenses_category(test_list):
    sum_e = total_expenses_category(test_list, 3, 'housekeeping')
    assert sum_e == 232
    insert_expense(test_list, '3 5213 housekeeping')
    sum_e = total_expenses_category(test_list, 3, 'housekeeping')
    assert sum_e == 5445
    sum_e = total_expenses_category(test_list, 30, 'internet')
    assert sum_e == 707


def test_sort_expenses(test_list):
    sorted_list = sort_expenses(test_list, 'day')
    assert len(sorted_list) == 9
    insert_expense(test_list, '3 123 others')
    sorted_list = sort_expenses(test_list, 'day')
    assert len(sorted_list) == 9
    remove_expense(test_list, '30')
    sorted_list = sort_expenses(test_list, 'day')
    assert len(sorted_list) == 8
    sorted_list = sort_expenses(test_list, 'transport')
    assert len(sorted_list) == 2
    assert sorted_list[0][0] == 8 and sorted_list[0][1] == 5
    assert sorted_list[1][0] == 27 and sorted_list[1][1] == 13
    try:
        sort_expenses(test_list, 'asfa')
        assert False
    except ValueError:
        assert True
    try:
        sort_expenses([], 'others')
        assert False
    except ValueError:
        assert True
    try:
        sort_expenses([], 'day')
        assert False
    except ValueError:
        assert True
    try:
        remove_expense(test_list, 'others')
        sort_expenses(test_list, 'others')
        assert False
    except ValueError:
        assert True


def test_init():
    test_how_many_spaces()
    test_check_category()
    test_create_expense()
    test_list = default_expenses()
    test_list_expenses(test_list)
    test_arguments_split_list_filter()
    test_add_expense(test_list)
    test_insert_expense(test_list)
    test_remove_expense(test_list)
    test_list = default_expenses()
    test_get_list_elements(test_list)
    test_undo(test_list)
    test_sum_expense(test_list)
    test_list = default_expenses()
    test_total_expenses_day(test_list)
    test_day_max_exp(test_list)
    test_filter_expenses(test_list)
    test_total_expenses_category(test_list)
    test_list = default_expenses()
    test_sort_expenses(test_list)
