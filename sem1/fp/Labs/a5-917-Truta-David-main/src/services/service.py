"""
    Service class includes functionalities for implementing program features
"""
from src.domain.entity import Book
import random
import string


class Services:

    def __init__(self):
        self.__books = {}
        self.__history = []
        self.default_books()

    def default_books(self):
        """
        Adds to the self.__books dictionary the books below, every time you open up the program.
        :return: -
        """
        self.add_book("So Good They can't ignore you", 'Cal Newport')
        self.add_book('The Last Wish', 'Andrzej Sapkowski')
        self.add_book('Sapiens: A Brief History of Humankind', 'Yuval Noah Harari')
        self.add_book('Think and Grow Rich', 'Napoleon Hill')
        self.add_book('How to win friends & influence people', 'Dale Carnegie')
        self.add_book('The Game', 'Niel Strauss')
        self.add_book('To Kill a Mocking Bird', 'Harper Lee')
        self.add_book('Rich Dad Poor Dad', 'Robert Kiyosaki ')
        self.add_book('Life is what you make it', 'Peter Buffet')
        self.add_book('Blood of Elves', 'Andrzej Sapkowski')

    def create_isbn(self):
        """
        Computes a unique string formed by digits only.
        :return: a string of 13 digits (isbn)
        """
        while True:
            isbn = ''.join(random.choice(string.digits) for _ in range(13))
            # isbn gets a randomly generated string formed by 13 digits
            if (isbn in self.__books.keys()) is False:
                # if the randomly generated string is unique, it breaks the while loop
                break
        isbn = isbn[:3] + '-' + isbn[3:]
        isbn = isbn[:5] + '-' + isbn[5:]
        isbn = isbn[:13] + '-' + isbn[13:]
        isbn = isbn[:15] + '-' + isbn[15:]
        return isbn

    def add_book(self, title, author):
        """
        Adds a book to the dictionary of books(self.__books) with the key being the isbn,
        and the value being the book object.
        :param title: (string) Title of the book
        :param author: (string) Author of the book
        :return: -
        Raises ValueError if title or author are empty strings.
        """
        if title == '' or author == '':
            raise ValueError("Title or Author cannot be empty!")
        if isinstance(title, str) is False or isinstance(author, str) is False:
            raise ValueError("Title or Author cannot be empty!")
        isbn = self.create_isbn()
        # creates unique isbn
        b = Book(isbn,  title.strip().capitalize(), author.strip().capitalize())
        # object of type Book(b) is created with the given arguments.
        self.__books[b.isbn] = b
        # object of type Book put into the dictionary, with isbn as it's key.

    def get_all_books(self):
        return list(self.__books.values())

    def rem_book_by_title_fw(self, word):
        word = word.strip().capitalize()
        books, i, exists = self.get_all_books(), 0, False
        while i < len(books):
            first_word = books[i].title.split(' ', 1)
            if first_word[0] == word:
                self.__books.pop(books[i].isbn)
                exists = True
            i += 1
        if exists is False:
            raise ValueError('There are no book titles starting with this word!')

    def add_to_history(self):
        self.__history.append(dict(self.__books))

    def undo(self):
        if len(self.__history) == 0:
            raise Exception('No more Undoes!')
        self.__books.clear()
        self.__books = self.__history[len(self.__history)-1]
        self.__history.pop()
