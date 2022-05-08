import datetime
import random

from domain.Entities import Rental
from services.UndoRedo import UndoHandler, UndoManager


class RentalService:

    def __init__(self, rent_repo, book_repo, client_repo, rand=5):
        self.__b_repo = book_repo
        self.__c_repo = client_repo
        self.__repo = rent_repo
        self.__rented_books = {}
        self.__clients_rent = {}
        self.__default_rentals(rand)

    @staticmethod
    def __random_date(start_date):
        end_date = datetime.date.today()

        time_between_dates = end_date - start_date
        days_between_dates = time_between_dates.days
        random_number_of_days = random.randrange(days_between_dates)
        random_date = start_date + datetime.timedelta(days=random_number_of_days)

        return random_date

    def __default_rentals(self, j):
        i = 0
        while True:
            if i == j:
                break
            books, clients = self.__b_repo.find_all_books(), self.__c_repo.find_all_clients()
            b = random.choice(books)
            while b.is_available is False:
                b = random.choice(books)
            b_id = b.book_id
            c = random.choice(clients)
            c_id = c.id
            random_rent_date = self.__random_date(datetime.date(2020, 1, 1))
            random_returned_date = self.__random_date(random_rent_date)
            random_returned_date = random.choice(['-', random_returned_date])
            self.add_rental(b_id, c_id, random_rent_date, random_returned_date)
            i += 1
        rentals = self.get_all_rentals()
        for rental in rentals:
            b = self.__b_repo.find_book_book_id(rental.book_id)
            if rental.returned_date != '-':
                b.is_available = True
            else:
                b.is_available = False

    @staticmethod
    def transform_to_id(book_id, cl_id, rent_date):
        day = rent_date.day
        month = rent_date.month
        year = rent_date.year
        if 9 >= day >= 1:
            day = '0' + str(day)
        if 9 >= month >= 1:
            month = '0' + str(month)
        return book_id.replace('-', '') + cl_id + str(day) + str(month) + str(year)

    def __create_id(self, book_id, cl_id, rent_date):
        id = self.transform_to_id(book_id, cl_id, rent_date)
        if id in self.get_all_rentals():
            raise ValueError('There already exists a rental with these properties!')
        return id

    def add_rental(self, book_id, cl_id, rent_date=datetime.date.today(), returned_date='-'):
        b = self.__b_repo.find_book_book_id(book_id)
        if b.is_available is False:
            raise ValueError('This book is not available!')
        self.__c_repo.find_client_id(cl_id)
        if returned_date == '-':
            b.is_available = False
        else:
            b.is_available = True
        new_rent = Rental(self.__create_id(book_id, cl_id, rent_date), book_id.strip(), cl_id.strip(), rent_date,
                          returned_date)
        self.__repo.save_rental(new_rent)
        UndoManager.register_operation(self.__repo, UndoHandler.ADD_RENTAL, new_rent)

    def return_book(self, book_id):
        rentals = self.get_all_rentals()
        book = self.__b_repo.find_book_book_id(book_id)
        for rental in rentals:
            if (rental.book_id == book_id) and (book.is_available is False) and (rental.returned_date == '-'):
                rental.returned_date = datetime.date.today()
                book.is_available = True
                UndoManager.register_operation(self.__b_repo, UndoHandler.RETURN_BOOK, rental)
                return None
        raise ValueError('Book cannot be returned, because it is not rented!')

    def get_all_rentals(self):
        return self.__repo.find_all_rentals()

    def times_rented_book(self, book):
        res = 0
        for b in self.__repo.find_all_rentals():
            if b.book_id == book.book_id:
                res += 1
        return res

    def most_rented_book(self):
        books = self.__b_repo.find_all_books()
        if not books:
            raise IndexError('The list is empty!')
        books.sort(reverse=True, key=self.times_rented_book)
        return books

    def times_rented_client(self, client):
        res = 0
        for c in self.__repo.find_all_rentals():
            if c.cl_id == client.id:
                if c.returned_date == '-':
                    res += (datetime.date.today() - c.rent_date).days
                else:
                    res += (c.returned_date - c.rent_date).days
        return res

    def most_active_client(self):
        clients = self.__c_repo.find_all_clients()
        if not clients:
            raise IndexError('The list is empty!')
        clients.sort(reverse=True, key=self.times_rented_client)
        return clients

    def times_rented_author(self, book):
        res = 0
        for r in self.__repo.find_all_rentals():
            bo = self.__b_repo.find_book_book_id(r.book_id)
            if bo.author == book.author:
                res += 1
        return res

    def most_rented_author(self):
        books, i = self.__b_repo.find_all_books(), 0
        books.sort(reverse=True, key=self.times_rented_author)
        while i < len(books):
            book = books[i]
            if book.author != books[0].author:
                books.remove(book)
                i -= 1
            i += 1
        if not books:
            raise IndexError('The list is empty!')
        books.sort(reverse=True, key=self.times_rented_book)
        return books[0].author, books

    def remove_all_rentals(self):
        self.__repo.delete_all_rentals()
