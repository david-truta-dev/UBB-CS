""" Tests for the functionalities are put in here!"""
from src.services.service import Services


def test_create_isbn(service):
    isbn = service.create_isbn()
    isbn = isbn.replace('-', '')
    assert isbn.isnumeric() and len(isbn) == 13

    # check if it is unique
    c, isbn2 = 0, ''
    while isbn != isbn2:
        c += 1
        isbn2 = service.create_isbn()
        if c > 10000:
            break
    assert c == 10001


def test_add_book(service):
    service.add_book('asdasd', 'author')
    books = service.get_all_books()
    assert len(books) == 11 and books[10].title == 'Asdasd' and books[10].author == 'Author'
    try:
        service.add_book('', '')
        assert False
    except ValueError:
        assert True
    try:
        service.add_book(123, 51241)
        assert False
    except ValueError:
        assert True


def test_init():
    service = Services()
    test_create_isbn(service)
    test_add_book(service)
