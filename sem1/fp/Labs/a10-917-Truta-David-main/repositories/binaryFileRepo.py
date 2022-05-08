import pickle

from repositories.inMemoryRepo import MemoryBookRepo, MemoryClientRepo, MemoryRentRepo
import os


class BinaryBookRepo(MemoryBookRepo):

    def __init__(self, file_name='Books.pickle'):
        super().__init__()
        self._file_name = file_name
        self.__load()

    def find_book_book_id(self, book_id):
        return super().find_book_book_id(book_id)

    def save_book(self, book):
        super().save_book(book)
        self.__save()

    def delete_book_book_id(self, book_id):
        super().delete_book_book_id(book_id)
        self.__save()

    def update_book(self, book):
        super().update_book(book)
        self.__save()

    def find_all_books(self):
        return super().find_all_books()

    def delete_all_books(self):
        super().delete_all_books()
        self.__save()

    def __save(self):
        f = open(self._file_name, 'wb')
        pickle.dump(self._books, f)
        f.close()

    def __load(self):
        if os.stat(self._file_name).st_size == 0:
            return None
        with open(self._file_name, 'rb') as f:
            self._books = pickle.load(f)
        f.close()


class BinaryClientRepo(MemoryClientRepo):

    def __init__(self, file_name='Clients.txt'):
        super().__init__()
        self._file_name = file_name
        self.__load()

    def find_client_id(self, id):
        return super().find_client_id(id)

    def save_client(self, client):
        super().save_client(client)
        self.__save()

    def delete_client_id(self, id):
        super().delete_client_id(id)
        self.__save()

    def update_client(self, client):
        super().update_client(client)
        self.__save()

    def find_all_clients(self):
        return super().find_all_clients()

    def delete_all_clients(self):
        super().delete_all_clients()
        self.__save()

    def __save(self):
        f = open(self._file_name, 'wb')
        pickle.dump(self._clients, f)
        f.close()

    def __load(self):
        if os.stat(self._file_name).st_size == 0:
            return None
        with open(self._file_name, 'rb') as f:
            self._clients = pickle.load(f)
        f.close()


class BinaryRentRepo(MemoryRentRepo):

    def __init__(self, file_name='Rentals.txt'):
        super().__init__()
        self._file_name = file_name
        self.__load()

    def find_rental(self, id):
        return super().find_rental(id)

    def save_rental(self, rental):
        super().save_rental(rental)
        self.__save()

    def delete_rental(self, id):
        super().delete_rental(id)
        self.__save()

    def update_rental(self, rental):
        super().update_rental(rental)
        self.__save()

    def delete_all_rentals(self):
        super().delete_all_rentals()
        self.__save()

    def find_all_rentals(self):
        return super().find_all_rentals()

    def __save(self):
        f = open(self._file_name, 'wb')
        pickle.dump(self._rentals, f)
        f.close()

    def __load(self):
        if os.stat(self._file_name).st_size == 0:
            return None
        with open(self._file_name, 'rb') as f:
            self._rentals = pickle.load(f)
        f.close()
