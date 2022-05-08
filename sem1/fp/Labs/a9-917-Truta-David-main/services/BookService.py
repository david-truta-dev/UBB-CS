import random
import string

from domain.Entities import Book
from domain.Validators import BookValidator
from services.UndoRedo import UndoManager, UndoHandler


class BookService:

    def __init__(self, bo_repository):
        self.__bo_repo = bo_repository

    def default_books(self, j):
        book_dict = {"So Good They can't ignore you": 'Cal Newport',
                     'The Last Wish': 'Andrzej Sapkowski', 'Sapiens: A Brief History of Humankind': 'Yuval Noah Harari',
                     'Think and Grow Rich': 'Napoleon Hill', 'How to win friends & influence people': 'Napoleon Hill',
                     'The Game': 'Niel Strauss', 'To Kill a Mocking Bird': 'Harper Lee',
                     'Rich Dad Poor Dad': 'Robert Kiyosaki', 'Life is what you make it': 'Peter Buffet',
                     'Blood of Elves': 'Andrzej Sapkowski', "The Glass Hotel": "Emily St. John Mandel",
                     "The Mirror and the Light": "Hilary Mantel", "Uncanny Valley": "Anna Wiener",
                     "Jack": "Marilynne Robinson", "Cleanness": "Garth Greenwell", "Perfect Tunes": "Emily Gould",
                     "It's Not All Downhill From Here: A Novel": "Terry McMillan",
                     "The City We Became": "N. K. Jemisin",
                     "Can't Even: How Millennials Became the Burnout Generation": "Anne Helen Petersen",
                     "Minor Feelings: An Asian American Reckoning": "Cathy Park Hong"}
        i = 0
        while True:
            if (not book_dict) or i == j:
                break
            title, author = random.choice(list(book_dict.items()))
            i += 1
            del book_dict[title]
            self.add_book(title, author)

    def __create_book_id(self):
        """
        Computes a unique string formed by 10 randomly generated digits, which represents the book_id.
        :return: a string of 10 digits (book_id)
        """
        while True:
            book_id = ''.join(random.choice(string.digits) for _ in range(10))
            # book_id gets a randomly generated string formed by 10 digits
            if (book_id in self.get_all_books()) is False:
                # if the randomly generated string is unique, it breaks the while loop
                break
        return book_id

    def add_book(self, title, author):
        """
        Creates a book object with a new book_id, the title(parameter), author(parameter) and True value
         for the Availability. Then it saves the book in the repositories if it is valid.
        :param title: (string) title of the book
        :param author: (string title of the book
        Raises BookValidatorException if book is not valid.
        :return:-
        """
        b = Book(self.__create_book_id(), ' '.join(title.title().split()), ' '.join(author.title().split()), True)
        BookValidator.validate_book(b)
        self.__bo_repo.save_book(b)
        UndoManager.register_operation(self.__bo_repo, UndoHandler.ADD_BOOK, b)

    def remove_book(self, book_id):
        book = self.find_books(book_id)[0]
        self.__bo_repo.delete_book_book_id(book_id)
        UndoManager.register_operation(self.__bo_repo, UndoHandler.REMOVE_BOOK, book)

    def update_book(self, book_id, title, author):
        b = Book(book_id, ' '.join(title.title().split()), ' '.join(author.title().split()))
        BookValidator.validate_book(b)
        book = self.find_books(book_id)[0]
        self.__bo_repo.update_book(b)
        UndoManager.register_operation(self.__bo_repo, UndoHandler.UPDATE_BOOK, book)

    def get_all_books(self):
        return self.__bo_repo.find_all_books()

    def find_books(self, arg):
        """
        Computes and returns a list of books that include the given string(arg) in one of their fields.
        :param arg: a string, which represents a part of a field OR a field OF a book object.
        :return: list of books
        Raises ValueError if no books that match have been found
        """
        books, res = self.get_all_books(), []
        for book in books:
            if arg in book.title.lower() or arg in book.author.lower() or arg in book.book_id:
                res.append(book)
        if not res:
            raise ValueError('No books have been found!')
        return res

    def remove_all_books(self):
        self.__bo_repo.delete_all_books()
