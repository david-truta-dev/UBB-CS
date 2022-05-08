import datetime
from dataclasses import dataclass
from enum import Enum


def add_book_handler(repo, book):
    repo.delete_book_book_id(book.book_id)
    RedoManager.register_undo(repo, RedoHandler.ADD_BOOK, book)


def remove_book_handler(repo, book):
    repo.save_book(book)
    RedoManager.register_undo(repo, RedoHandler.REMOVE_BOOK, book)


def update_book_handler(repo, book):
    b = repo.find_book_book_id(book.book_id)
    repo.update_book(book)
    RedoManager.register_undo(repo, RedoHandler.UPDATE_BOOK, b)


def add_client_handler(repo, client):
    repo.delete_client_id(client.id)
    RedoManager.register_undo(repo, RedoHandler.ADD_CLIENT, client)


def remove_client_handler(c_repo, client, ch_rental_ids, r_repo, b_repo):
    c_repo.save_client(client)
    for id in ch_rental_ids:
        rental = r_repo.find_rental(id)
        book = b_repo.find_book_book_id(rental.book_id)
        book.is_available = False
        rental.returned_date = '-'
    RedoManager.register_undo(c_repo, RedoHandler.REMOVE_CLIENT, client, ch_rental_ids, r_repo, b_repo)


def update_client_handler(repo, client):
    c = repo.find_client_id(client.id)
    repo.update_client(client)
    RedoManager.register_undo(repo, RedoHandler.UPDATE_CLIENT, c)


def add_rental_handler(repo, rental):
    repo.delete_rental(rental.id)
    RedoManager.register_undo(repo, RedoHandler.ADD_RENTAL, rental)


def return_book_handler(b_repo, rental):
    rental.returned_date = '-'
    b = b_repo.find_book_book_id(rental.book_id)
    b.is_available = False
    RedoManager.register_undo(b_repo, RedoHandler.RETURN_BOOK, rental)


class UndoHandler(Enum):
    ADD_BOOK = add_book_handler
    ADD_CLIENT = add_client_handler
    ADD_RENTAL = add_rental_handler
    REMOVE_BOOK = remove_book_handler
    REMOVE_CLIENT = remove_client_handler
    RETURN_BOOK = return_book_handler
    UPDATE_BOOK = update_book_handler
    UPDATE_CLIENT = update_client_handler


@dataclass
class UndoOperation:
    target_object: object
    handler: object
    args: tuple


class UndoManager:
    __undo_operations = []

    @staticmethod
    def register_operation(target_object, handler, *args):
        UndoManager.__undo_operations.append(UndoOperation(target_object, handler, args))

    @staticmethod
    def undo():
        if not UndoManager.__undo_operations:
            raise IndexError("There are no more undoes!")
        undo_operation = UndoManager.__undo_operations.pop()
        undo_operation.handler(undo_operation.target_object, *undo_operation.args)

    @staticmethod
    def clear_undoes():
        UndoManager.__undo_operations.clear()


# ========================================== REDO =====================================================================


def add_book_handler_redo(repo, book):
    repo.save_book(book)
    UndoManager.register_operation(repo, UndoHandler.ADD_BOOK, book)


def remove_book_handler_redo(repo, book):
    repo.delete_book_book_id(book.book_id)
    UndoManager.register_operation(repo, UndoHandler.REMOVE_BOOK, book)


def update_book_handler_redo(repo, book):
    b = repo.find_book_book_id(book.book_id)
    repo.update_book(book)
    UndoManager.register_operation(repo, UndoHandler.UPDATE_BOOK, b)


def add_client_handler_redo(repo, client):
    repo.save_client(client)
    UndoManager.register_operation(repo, UndoHandler.ADD_CLIENT, client)


def remove_client_handler_redo(c_repo, client, ch_rental_ids, r_repo, b_repo):
    c_repo.delete_client_id(client.id)
    for id in ch_rental_ids:
        rental = r_repo.find_rental(id)
        book = b_repo.find_book_book_id(rental.book_id)
        book.is_available = True
        rental.returned_date = datetime.date.today()
    UndoManager.register_operation(c_repo, UndoHandler.REMOVE_CLIENT, client, ch_rental_ids, r_repo, b_repo)


def update_client_handler_redo(repo, client):
    c = repo.find_client_id(client.id)
    repo.update_client(client)
    UndoManager.register_operation(repo, UndoHandler.UPDATE_CLIENT, c)


def add_rental_handler_redo(repo, rental):
    repo.save_rental(rental)
    UndoManager.register_operation(repo, UndoHandler.ADD_RENTAL, rental)


def return_book_handler_redo(b_repo, rental):
    rental.returned_date = datetime.date.today()
    b = b_repo.find_book_book_id(rental.book_id)
    b.is_available = True
    UndoManager.register_operation(b_repo, UndoHandler.RETURN_BOOK, rental)


class RedoHandler(Enum):
    ADD_BOOK = add_book_handler_redo
    ADD_CLIENT = add_client_handler_redo
    ADD_RENTAL = add_rental_handler_redo
    REMOVE_BOOK = remove_book_handler_redo
    REMOVE_CLIENT = remove_client_handler_redo
    RETURN_BOOK = return_book_handler_redo
    UPDATE_BOOK = update_book_handler_redo
    UPDATE_CLIENT = update_client_handler_redo


@dataclass
class RedoOperation:
    target: object
    handler: object
    args: tuple


class RedoManager:
    __redo_operations = []

    @staticmethod
    def register_undo(target, handler, *args):
        RedoManager.__redo_operations.append(RedoOperation(target, handler, args))

    @staticmethod
    def redo():
        if not RedoManager.__redo_operations:
            raise IndexError("There are no more redoes!")
        redo = RedoManager.__redo_operations.pop()
        redo.handler(redo.target, *redo.args)

    @staticmethod
    def clear_redoes():
        RedoManager.__redo_operations.clear()
