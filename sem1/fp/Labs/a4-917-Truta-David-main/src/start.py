"""
Assemble the program and start the user interface here
"""
from src.functions.functions import default_expenses
from src.tests.functionalities_test import test_init
from src.ui.console import run_command_ui


def start():
    test_init()
    exp_data = default_expenses()
    run_command_ui(exp_data)


start()
