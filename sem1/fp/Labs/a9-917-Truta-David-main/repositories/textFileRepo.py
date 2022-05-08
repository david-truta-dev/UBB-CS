from domain.Entities import Book, Client, Rental
from repositories.inMemoryRepo import MemoryBookRepo, MemoryClientRepo, MemoryRentRepo


class TextBookRepo(MemoryBookRepo):

    def __init__(self, file_name='Books.txt'):
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
        f = open(self._file_name, 'wt')
        for book in self._books.values():
            line = book.book_id + ';' + book.title + ';' + book.author
            f.write(line)
            f.write('\n')
        f.close()

    def __load(self):
        f = open(self._file_name, 'rt')  # read text
        lines = f.readlines()
        f.close()

        for line in lines:
            if line == '\n':
                break
            line = line.replace('\n', '').split(';')
            super().save_book(Book(line[0], line[1], line[2]))


class TextClientRepo(MemoryClientRepo):

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
        f = open(self._file_name, 'wt')
        for client in self._clients.values():
            line = client.id + ';' + client.name
            f.write(line)
            f.write('\n')
        f.close()

    def __load(self):
        f = open(self._file_name, 'rt')  # read text
        lines = f.readlines()
        f.close()

        for line in lines:
            if line == '\n':
                break
            line = line.replace('\n', '').split(';')
            super().save_client(Client(line[0], line[1]))


class TextRentRepo(MemoryRentRepo):

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
        f = open(self._file_name, 'wt')
        for rental in self._rentals.values():
            line = rental.id + ';' + rental.book_id + ';' + rental.cl_id + ';' + str(rental.rent_date) + ';'\
                   + str(rental.returned_date)
            f.write(line)
            f.write('\n')
        f.close()

    def __load(self):
        f = open(self._file_name, 'rt')  # read text
        lines = f.readlines()
        f.close()

        for line in lines:
            if line == '\n':
                break
            line = line.replace('\n', '').split(';')
            super().save_rental(Rental(line[0], line[1], line[2], line[3], line[4]))
