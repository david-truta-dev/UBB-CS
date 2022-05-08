from controller import Controller
from repository import Repository
from ui import Ui

if __name__ == "__main__":
    repo = Repository()
    controller = Controller(repo)
    consoleUi = Ui(controller)

    consoleUi.run()
