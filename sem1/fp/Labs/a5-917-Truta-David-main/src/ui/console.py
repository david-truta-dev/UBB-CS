"""
    UI class.

    Calls between program modules
    ui -> service -> entity
    ui -> entity
"""
from services.service import Services


class Ui:

    def __init__(self):
        self.__services = Services()

    @staticmethod
    def ui_menu():
        print("This program manages a list of books. Available commands:"
              "\n\t'a' - add a book to the list"
              "\n\t'd' - display the list of books"
              "\n\t'f' - filter list"
              "\n\t'u' - undo last operation that modified program data"
              "\n\t'x' - exit")

    def ui_add_book(self):
        self.__services.add_book(input('Title of the book:'), input('Author of the book:'))
        print('Book added successfully!')

    def ui_display_books(self):
        books, c = self.__services.get_all_books(), 1
        print('')
        for book in books:
            pr = '{:<4}'.format(str(c) + '. ')
            print(pr, book)
            c += 1
        input('\nHit Enter to continue.')

    def ui_filter(self):
        print('Enter a word so that book titles starting with this word are deleted from the list.')
        self.__services.rem_book_by_title_fw(input('>'))
        print('Filtered successfully!')

    def ui_undo(self):
        self.__services.undo()
        print('Undo was successful!')

    def run_console(self):
        com_dict = {'a': self.ui_add_book, 'd': self.ui_display_books, 'f': self.ui_filter, 'u': self.ui_undo}
        while True:
            self.ui_menu()
            command = input('Give command:')
            if command == 'x':
                break
            elif command in com_dict.keys():
                try:
                    if command != 'd' and command != 'u':
                        self.__services.add_to_history()
                    com_dict[command]()
                except Exception as ex:
                    print(ex)
            else:
                print('Enter a relevant command!')
            print('')
