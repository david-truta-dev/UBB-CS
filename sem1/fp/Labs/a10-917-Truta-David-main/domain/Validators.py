

class StoreException(Exception):
    pass


class BookValidatorException(StoreException):
    pass


class BookValidator:
    @staticmethod
    def validate_book(book):
        # book = (ISBN, Title, Author)
        # Book_id is not entered by the user, so no need to be validated
        if book.title == '':
            raise BookValidatorException("Title field cannot be empty!")
        if book.author == '':
            raise BookValidatorException("Author field cannot be empty!")


class ClientValidatorException(StoreException):
    pass


class ClientValidator:
    @staticmethod
    def validate_client(client):
        # client = (ID, Name)
        # ID is generated, so no need to validate.
        if client.name == '':
            raise ClientValidatorException('Name field cannot be empty!')
