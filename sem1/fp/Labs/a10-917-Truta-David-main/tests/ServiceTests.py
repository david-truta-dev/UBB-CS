from domain.Validators import BookValidatorException, ClientValidatorException


def add_book_test(book_service):
    book_service.add_book('   title ', '   author   ')
    assert len(book_service.get_all_books()) == 11
    exists, b_id = False, ''
    for book in book_service.get_all_books():
        if book.title == 'Title' and book.author == 'Author':
            exists = True
            b_id = book.book_id
            break
    assert exists
    book_service.remove_book(b_id)
    try:
        book_service.add_book('', 'asfsag')
        assert False
    except BookValidatorException:
        assert True
    try:
        book_service.add_book('gasrfa', '')
        assert False
    except BookValidatorException:
        assert True
    try:
        book_service.add_book('', '')
        assert False
    except BookValidatorException:
        assert True


def add_client_test(client_service):
    client_service.add_client('  name   ')
    assert len(client_service.get_all_clients()) == 11
    exists, c_id = False, ''
    for client in client_service.get_all_clients():
        if client.name == 'Name':
            exists = True
            c_id = client.id
            break
    assert exists
    client_service.remove_client(c_id)
    try:
        client_service.add_client('')
        assert False
    except ClientValidatorException:
        assert True


def init_tests(b_service, c_service):
    add_book_test(b_service)
    add_client_test(c_service)
