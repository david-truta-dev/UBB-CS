"""
    Here is the definition of Book class.
"""


class Book:

    def __init__(self, book_id='', title='', author='', is_available=True):
        self.__is_available = is_available
        self.__book_id = book_id
        self.__author = author
        self.__title = title

    @property
    def book_id(self):
        return self.__book_id

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

    @property
    def is_available(self):
        return self.__is_available

    @is_available.setter
    def is_available(self, value):
        self.__is_available = value

    def __str__(self):
        return "Book ID: {:<5}   |  Title: {:<60}   |" \
               "   Author: {:<25}  |  Available: {bool:}".format(self.__book_id, self.__title,
                                                                 self.__author, bool=self.__is_available)


class Client:

    def __init__(self, client_id, name):
        self.__client_id = client_id
        self.__name = name

    @property
    def id(self):
        return self.__client_id

    @id.setter
    def id(self, value):
        self.__client_id = value

    @property
    def name(self):
        return self.__name

    @name.setter
    def name(self, value):
        self.__name = value

    def __str__(self):
        return "ID: {:<20}  |   Name: {:<40}".format(self.__client_id, self.__name)


class Rental:

    def __init__(self, id, book_id, cl_id, rent_date, returned_date):
        self.__r_id = id
        self.__book_id = book_id
        self.__cl_id = cl_id
        self.__rent_date = rent_date
        self.__returned_date = returned_date

    @property
    def id(self):
        return self.__r_id

    @id.setter
    def id(self, value):
        self.__r_id = value

    @property
    def book_id(self):
        return self.__book_id

    @book_id.setter
    def book_id(self, value):
        self.__book_id = value

    @property
    def cl_id(self):
        return self.__cl_id

    @cl_id.setter
    def cl_id(self, value):
        self.cl_id = value

    @property
    def rent_date(self):
        return self.__rent_date

    @rent_date.setter
    def rent_date(self, value):
        self.__rent_date = value

    @property
    def returned_date(self):
        return self.__returned_date

    @returned_date.setter
    def returned_date(self, value):
        self.__returned_date = value

    def __str__(self):
        return "Rent ID: {:<15}  |  Book ID: {:<15}  |  Client ID: {:<10}  |  Rent Date:{date1:}  |  " \
               "Returned Date:{date2:}".format(self.__r_id, self.__book_id, self.__cl_id,
                                               date1=self.__rent_date, date2=self.__returned_date)
