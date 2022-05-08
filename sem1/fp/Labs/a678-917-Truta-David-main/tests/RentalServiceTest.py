from datetime import date
from unittest.case import TestCase

from repository.Repository import RentRepo, BookRepo, ClientRepo
from services.BookService import BookService
from services.ClientService import ClientService
from services.RentalService import RentalService


class RentalServiceTest(TestCase):

    def setUp(self):
        r_rep, b_rep, c_rep = RentRepo(), BookRepo(), ClientRepo()
        self._r_service = RentalService(r_rep, b_rep, c_rep, 0)
        self._b_service = BookService(b_rep, 20)
        self._c_service = ClientService(c_rep, r_rep, b_rep, 20)

    def test_most_rented_book(self):
        # Adding 2 rentals for 'The Last Wish':
        book = self._b_service.find_books('the last wish')[0]
        client = self._c_service.find_clients('dacia')[0]
        self._r_service.add_rental(book.book_id, client.id)
        self._r_service.return_book(book.book_id)
        client = self._c_service.find_clients('marva')[0]
        self._r_service.add_rental(book.book_id, client.id)
        # Adding a rental for 'Blood of Elves':
        book2 = self._b_service.find_books('blood of elves')[0]
        self._r_service.add_rental(book2.book_id, client.id)
        sorted_l = self._r_service.most_rented_book()
        # Check the first book is The Last Wish:
        self.assertEqual(sorted_l[0].title, 'The Last Wish')
        # Check the second book is Blood Of Elves:
        self.assertEqual(sorted_l[1].title, 'Blood Of Elves')
        # Check the list contains all books:
        self.assertEqual(len(sorted_l), 20)
        # Check it raises error:
        self._b_service.remove_all_books()
        self.assertRaises(IndexError, self._r_service.most_rented_book)

    def test_most_active_client(self):
        self._r_service.remove_all_rentals()
        book = self._b_service.find_books('the last wish')[0]
        client = self._c_service.find_clients('dacia')[0]
        self._r_service.add_rental(book.book_id, client.id, date(2020, 1, 1), date(2020, 5, 30))
        client = self._c_service.find_clients('irvin')[0]
        self._r_service.add_rental(book.book_id, client.id, date(2020, 6, 1), date(2020, 7, 1))
        self._r_service.add_rental(book.book_id, client.id, date(2020, 7, 2), date(2020, 7, 28))

        sorted_l = self._r_service.most_active_client()

        self.assertIn('Dacia', sorted_l[0].name)
        self.assertIn('Irvin', sorted_l[1].name)
        # Check it raises error:
        self._c_service.remove_all_clients()
        self.assertRaises(IndexError, self._r_service.most_active_client)

    def test_most_rented_author(self):
        self._r_service.remove_all_rentals()
        book = self._b_service.find_books('napoleon hill')[0]
        client = self._c_service.find_clients('dacia')[0]
        self._r_service.add_rental(book.book_id, client.id, date(2020, 1, 1), date(2020, 1, 2))
        self._r_service.add_rental(book.book_id, client.id, date(2020, 1, 3), date(2020, 1, 4))
        self._r_service.add_rental(book.book_id, client.id, date(2020, 1, 5), date(2020, 1, 6))

        author, sorted_l = self._r_service.most_rented_author()

        self.assertEqual('Napoleon Hill', author)
        self.assertEqual('Napoleon Hill', sorted_l[0].author)
        self.assertEqual('Napoleon Hill', sorted_l[1].author)
        self.assertEqual(len(sorted_l), 2)
        # Check it raises error:
        self._b_service.remove_all_books()
        self.assertRaises(IndexError, self._r_service.most_rented_book)
