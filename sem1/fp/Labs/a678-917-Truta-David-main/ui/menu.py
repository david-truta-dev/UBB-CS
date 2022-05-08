"""
    Here the Menu class is defined.
"""
from services.UndoRedo import UndoManager, RedoManager


class Menu:

    def __init__(self, b_service, c_service, r_service):
        self.__current_manager = 'books'
        self.__book_service = b_service
        self.__client_service = c_service
        self.__rental_service = r_service

    def ui_menu(self):
        print("Available commands for "
              + self.__current_manager
              + ":"
                "\n\t's' - switch from managing clients to managing books or the reverse "
                "\n\t'a' - add to list "
                "\n\t'r' - remove from list"
                "\n\t'u' - update element"
                "\n\t'd' - display the list"
                "\n\t'f' - find an element"
                "\nAvailable commands for rentals:"
                "\n\t'-' - rent book"
                "\n\t'+' - return a book"
                "\n\t'l' - list rentals"
                "\nAvailable commands for statistics:"
                "\n\t'mrb' - list in order of most rented books"
                "\n\t'mac' - list in order of most active client"
                "\n\t'mra' - list in order of most rented author"
                "\nOther commands:"
                "\n\t'ud' - undo last operation"
                "\n\t'rd' - redo"
                "\n\t'x' - exit")

    def ui_add(self):
        if self.__current_manager == 'clients':
            self.__client_service.add_client(input('Name:').strip())
        else:
            self.__book_service.add_book(input('Title of the book:').strip(), input('Author of the book:').strip())
        print(self.__current_manager.replace('s', '').capitalize() + ' added successfully!')

    def ui_display(self):
        if self.__current_manager == 'books':
            self.ui_display_a_list(self.__book_service.get_all_books())
        else:
            self.ui_display_a_list(self.__client_service.get_all_clients())
        print('')

    def ui_remove(self):
        if self.__current_manager == 'books':
            self.__book_service.remove_book(input('Book ID:').strip())
        else:
            self.__client_service.remove_client(input('Client ID:').strip())
        print(self.__current_manager.replace('s', '').capitalize() + ' removed successfully!')

    def ui_update(self):
        if self.__current_manager == 'books':
            self.__book_service.update_book(input('Book ID:').strip(), input('Title:').strip(),
                                            input('Author:').strip())
        else:
            self.__client_service.update_client(input('Client ID:').strip(), input('Name:').strip())
        print(self.__current_manager.replace('s', '').capitalize() + ' updated successfully!')

    def ui_switch_manager(self):
        if self.__current_manager == 'books':
            self.__current_manager = 'clients'
        else:
            self.__current_manager = 'books'
        print('Manager has been switched!')

    def ui_rent_book(self):
        self.__rental_service.add_rental(input('Book ID:').strip(), input('Client ID:').strip())
        print('Rental successfully added!')

    def ui_return_book(self):
        self.__rental_service.return_book(input('Book ID:').strip())
        print('Book returned successfully!')

    def ui_list_rentals(self):
        self.ui_display_a_list(self.__rental_service.get_all_rentals())

    def ui_find(self):
        if self.__current_manager == 'books':
            elements = self.__book_service.find_books(input('Enter Book ID, Title or Author >').lower().strip())
        else:
            elements = self.__client_service.find_clients(input('Enter Client ID or Name >').lower().strip())
        c = 1
        for element in elements:
            pr = '{:<4}'.format(str(c) + '. ')
            print(pr, element)
            c += 1
        input('\nHit Enter to continue.')

    def ui_most_rented_book(self):
        self.ui_display_a_list(self.__rental_service.most_rented_book())

    def ui_most_active_client(self):
        self.ui_display_a_list(self.__rental_service.most_active_client())

    def ui_most_rented_author(self):
        author, print_list = self.__rental_service.most_rented_author()
        print('The most rented autohr is ', author, '.', sep='')
        print('Books writen by ', author, ' :', sep='')
        self.ui_display_a_list(print_list)

    @staticmethod
    def ui_display_a_list(list):
        elements, c = list, 1
        print('')
        for element in elements:
            pr = '{:<4}'.format(str(c) + '. ')
            print(pr, element)
            c += 1
        input('\nHit Enter to continue.')

    @staticmethod
    def ui_undo():
        UndoManager.undo()
        print('The undo was successful!')

    @staticmethod
    def ui_redo():
        RedoManager.redo()
        print('The redo was successful!')

    def run_console(self):
        UndoManager.clear_undoes()
        com_dict = {'s': self.ui_switch_manager, 'a': self.ui_add, 'd': self.ui_display, 'r': self.ui_remove,
                    'u': self.ui_update, '-': self.ui_rent_book, '+': self.ui_return_book, 'l': self.ui_list_rentals,
                    'f': self.ui_find, 'mrb': self.ui_most_rented_book, 'mac': self.ui_most_active_client,
                    'mra': self.ui_most_rented_author, 'ud': self.ui_undo, 'rd': self.ui_redo}
        while True:
            self.ui_menu()
            command = input('Give command:').lower().strip()
            if command == 'x':
                break
            elif command in com_dict.keys():
                try:
                    com_dict[command]()
                except Exception as ex:
                    print(ex)
            else:
                print('Enter a relevant command!')
            print('')
