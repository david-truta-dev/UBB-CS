from unittest.case import TestCase

from repositories.inMemoryRepo import MemoryBookRepo
from services.BookService import BookService


class BookServiceTest(TestCase):

    def setUp(self):
        self._service = BookService(MemoryBookRepo())
        self._service.default_books(20)

    def test_find_book(self):
        # Testing for finding by title:
        res = self._service.find_books("good they can't")
        self.assertEqual(res[0].title, "So Good They Can'T Ignore You")
        # Testing for finding by id:
        res1 = self._service.find_books('last wish')
        res2 = self._service.find_books(res1[0].book_id)
        self.assertEqual(res2[0].title, 'The Last Wish')
        # Testing for finding by author:
        res = self._service.find_books("hilary mantel")
        self.assertEqual(res[0].title, "The Mirror And The Light")
        self.assertEqual(len(res), 1)
        res = self._service.find_books("andrzej")
        self.assertEqual(len(res), 2)
        # Testing it raises exception
        self.assertRaises(ValueError, self._service.find_books, 'this shold not exist :)')
