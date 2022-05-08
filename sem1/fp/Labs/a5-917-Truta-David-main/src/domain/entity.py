"""
    Entity class should be coded here
"""


class Book:

    def __init__(self, isbn='', title='', author=''):
        self.__isbn = isbn
        self.__author = author
        self.__title = title

    @property
    def isbn(self):
        return self.__isbn

    @property
    def author(self):
        return self.__author

    @property
    def title(self):
        return self.__title

    @author.setter
    def author(self, value):
        self.__author = value

    @title.setter
    def title(self, value):
        self.__title = value

    def __str__(self):
        return "ISBN:{:<5}   |  Title: {:<40}   |   Author: {:<20}".format(self.__isbn, self.__title, self.__author)
