
class MainMenu:
    def __init__(self, tournament):
        self.__service = tournament

    @staticmethod
    def menu():
        print('------Available commands:------\n'
              "'start tournament'\n"
              "'display players'\n"
              "'exit'\n")

    def display_all(self):
        for player in self.__service.get_all_players():
            print(player)

    def start_tournament(self):
        self.__service.start_tournament()

    def run(self):
        while True:
            self.menu()
            command = input('>').strip().lower()
            if command == 'exit':
                break
            elif command == 'display players':
                self.display_all()
            elif command == 'start tournament':
                self.start_tournament()
                input('\tPress ENTER to continue')
            else:
                print('Enter a relevant command!')
