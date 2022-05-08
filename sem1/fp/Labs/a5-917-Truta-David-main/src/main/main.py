""" Here we construct the program"""
from tests.functionalities import test_init
from ui.console import Ui


def start():
    test_init()
    console = Ui()
    console.run_console()


start()
