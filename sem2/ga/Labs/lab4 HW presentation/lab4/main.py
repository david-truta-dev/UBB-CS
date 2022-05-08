from service.graphService import GraphService
from ui.consoleUi import ConsoleUi

if __name__ == '__main__':
    service = GraphService()
    ui = ConsoleUi(service)

    ui.run()
