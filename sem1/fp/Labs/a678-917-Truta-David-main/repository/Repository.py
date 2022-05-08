

class StoreException(Exception):
    pass


class RepoException(StoreException):
    pass


class BookRepo:

    def __check_book_id(self, book_id):
        if book_id not in self.__books.keys():
            raise RepoException('There is no book with this ID!')

    def __init__(self):
        self.__books = {}

    def find_book_book_id(self, book_id):
        self.__check_book_id(book_id)
        return self.__books[book_id]

    def save_book(self, book):
        """
        Stores in the self.__books  dictionary a valid book.
        :param book: An object of type Book.
        :return:-
        """
        self.__books[book.book_id] = book

    def delete_book_book_id(self, book_id):
        self.__check_book_id(book_id)
        self.__books.pop(book_id)

    def update_book(self, book):
        self.__check_book_id(book.book_id)
        self.__books[book.book_id] = book

    def find_all_books(self):
        return list(self.__books.values())

    def delete_all_books(self):
        self.__books.clear()


class ClientRepo:

    def __check_id(self, id):
        if (id in self.__clients.keys()) is False:
            raise RepoException('There is no client with this ID!')

    def __init__(self):
        self.__clients = {}

    def find_client_id(self, id):
        self.__check_id(id)
        return self.__clients[id]

    def save_client(self, client):
        """
        Stores to the self.__clients dictionary a valid client.
        :param client: An object of type client.
        :return: -
        """
        self.__clients[client.id] = client

    def delete_client_id(self, id):
        self.__check_id(id)
        self.__clients.pop(id)

    def update_client(self, client):
        self.__check_id(client.id)
        self.__clients[client.id] = client

    def find_all_clients(self):
        return list(self.__clients.values())

    def delete_all_clients(self):
        self.__clients.clear()


class RentRepo:

    def __check_id(self, id):
        if (id in self.__rentals.keys()) is False:
            raise ValueError('There is no rental with this ID!')

    def __init__(self):
        self.__rentals = {}

    def find_rental(self, id):
        self.__check_id(id)
        return self.__rentals[id]

    def save_rental(self, rental):
        self.__rentals[rental.id] = rental

    def delete_rental(self, id):
        self.__check_id(id)
        self.__rentals.pop(id)

    def update_rental(self, id, rental):
        self.__check_id(id)
        self.__rentals[id] = rental

    def delete_all_rentals(self):
        self.__rentals.clear()

    def find_all_rentals(self):
        return list(self.__rentals.values())
