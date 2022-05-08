

class StoreException(Exception):
    pass


class RepoException(StoreException):
    pass


class MemoryBookRepo:

    def __check_book_id(self, book_id):
        if book_id not in self._books.keys():
            raise RepoException('There is no book with this ID!')

    def __init__(self):
        self._books = {}

    def find_book_book_id(self, book_id):
        self.__check_book_id(book_id)
        return self._books[book_id]

    def save_book(self, book):
        """
        Stores in the self._books  dictionary a valid book.
        :param book: An object of type Book.
        :return:-
        """
        self._books[book.book_id] = book

    def delete_book_book_id(self, book_id):
        self.__check_book_id(book_id)
        self._books.pop(book_id)

    def update_book(self, book):
        self.__check_book_id(book.book_id)
        self._books[book.book_id] = book

    def find_all_books(self):
        return list(self._books.values())

    def delete_all_books(self):
        self._books.clear()


class MemoryClientRepo:

    def __check_id(self, id):
        if (id in self._clients.keys()) is False:
            raise RepoException('There is no client with this ID!')

    def __init__(self):
        self._clients = {}

    def find_client_id(self, id):
        self.__check_id(id)
        return self._clients[id]

    def save_client(self, client):
        """
        Stores to the self._clients dictionary a valid client.
        :param client: An object of type client.
        :return: -
        """
        self._clients[client.id] = client

    def delete_client_id(self, id):
        self.__check_id(id)
        self._clients.pop(id)

    def update_client(self, client):
        self.__check_id(client.id)
        self._clients[client.id] = client

    def find_all_clients(self):
        return list(self._clients.values())

    def delete_all_clients(self):
        self._clients.clear()


class MemoryRentRepo:

    def __check_id(self, id):
        if (id in self._rentals.keys()) is False:
            raise ValueError('There is no rental with this ID!')

    def __init__(self):
        self._rentals = {}

    def find_rental(self, id):
        self.__check_id(id)
        return self._rentals[id]

    def save_rental(self, rental):
        self._rentals[rental.id] = rental

    def delete_rental(self, id):
        self.__check_id(id)
        self._rentals.pop(id)

    def update_rental(self, rental):
        self.__check_id(rental.id)
        self._rentals[rental.id] = rental

    def delete_all_rentals(self):
        self._rentals.clear()

    def find_all_rentals(self):
        return list(self._rentals.values())
