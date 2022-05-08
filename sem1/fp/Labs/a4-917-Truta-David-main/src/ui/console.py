"""
This is the user interface module. These functions call functions from the domain and functions module.
"""
from src.domain.entity import get_expense_day, get_expense_type, get_expense_money
from src.functions.functions import add_expense, split_command, insert_expense, remove_expense, \
    undo, get_list_elements, sum_expense, day_max_exp, filter_expenses, sort_expenses, list_expenses

        
def ui_add_expense(exp_data, params):
    add_expense(exp_data, params)
    print('Expense added successfully!')


def ui_insert_expense(exp_data, params):
    insert_expense(exp_data, params)
    print('Expense inserted successfully!')


def ui_remove_expense(exp_data, params):
    remove_expense(exp_data, params)
    print('Expense(s) removed successfully!')


def ui_list_expense(exp_data, params):
    """
    Calls list_expense(), which returns the list which should be printed.
    :param exp_data: list of expenses
    :param params: string expected to be of the form 'housekeeping' ; 'others < 700'
    """
    list_data = list_expenses(exp_data, params)
    c = 1
    for expense in list_data:
        print("Expense", c, ":  ", "day:", get_expense_day(expense), "| amount of money:",
              get_expense_money(expense), "| expense type:", get_expense_type(expense))
        c += 1


def ui_help():
    print("\nCommands:\n"
          "1: list\t|\t list <category>\t|\t list <category> ['<'|'='|'>'] <value>"
          "\n2: add <sum> <category>"
          "\n3: insert <day> <sum> <category>"
          "\n4: remove <day>\t|\t remove <start day> to <end day>\t|\t remove <category>"
          "\n5: sum <category>"
          "\n6: max day"
          "\n7: sort day\t|\t sort <category>"
          "\n8: filter <category>\t|\t filter <category> [ < | = | > ] <value>"
          "\n9: undo\n")


def ui_undo(exp_data, history):
    undo(exp_data, history)
    print('Undone last operation successfully!')


def ui_sum_expense(exp_data, params):
    e_sum = sum_expense(exp_data, params)
    # params is a category, and e_sum is the total expense for a category
    print("The total expense for category", params, 'is', e_sum)


def ui_day_max_exp(exp_data, params):
    mx_days, mx_days_amount = day_max_exp(exp_data, params)
    print("The day(s) with the maximum amount is/are: ", end='')
    print(*mx_days, sep=', ', end='.')
    print(' And the maximum amount is:', mx_days_amount)


def ui_filter_expenses(exp_data, params):
    filter_expenses(exp_data, params)
    print("Filtered successfully!")


def ui_sort_expenses(exp_data, params):
    display_list = sort_expenses(exp_data, params)
    # display_list is the sorted list that should be printed
    if params == 'day':
        print("Total daily expenses, sorted by amount spent each day:")
        for daily_exp in display_list:
            print('Day:', daily_exp[0], 'Amount spent in this day:', daily_exp[1])
    else:
        print("Daily expenses form category", params, ", sorted by amount spent each day:")
        for daily_exp in display_list:
            print('Day:', daily_exp[0], 'Amount spent in category', params, 'on this day:', daily_exp[1])


def run_command_ui(exp_data):
    """
    Main UI function
    Calls all the other ui functions
    """
    history = []
    # history stores a list of lists of expenses at each step that modifies the list of expenses
    print("To see the available commands type 'help' and hit enter.")
    com_dictionary = {'add': ui_add_expense, 'insert': ui_insert_expense, 'remove': ui_remove_expense,
                      'list': ui_list_expense, 'filter': ui_filter_expenses, 'sort': ui_sort_expenses,
                      'sum': ui_sum_expense, 'max day': ui_day_max_exp}
    while True:
        command = input('command >').strip().lower()
        com_word, com_param = split_command(command)
        if command == 'exit' or command == 'x':
            break
        elif command == 'help':
            ui_help()
        elif command == 'undo':
            try:
                ui_undo(exp_data, history)
            except IndexError as ie:
                print(ie)
        elif com_word in com_dictionary:
            try:
                if com_word != 'list' and com_word != 'sum' and com_word != 'max day' and com_word != 'sort':
                    history.append(get_list_elements(exp_data))
                    # appends to history only for functions that modify the list
                com_dictionary[com_word](exp_data, com_param)
                # 'com_dictionary[com_word]' gets replaced by the corresponding value from com_dictionary
                # and a function is called
            except ValueError as ve:
                if com_word != 'list' and com_word != 'sum' and com_word != 'max day' and com_word != 'sort' \
                        and len(history) > 0:
                    history.pop()
                    # In case 'com_dictionary[com_word](exp_data, com_param)' raised an error, we pop the list entered
                    # because it would actually be the current list.
                print(ve)
        else:
            print("Enter a relevant command!")
