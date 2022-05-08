from repositories.binaryFileRepo import BinaryBookRepo, BinaryClientRepo, BinaryRentRepo
from repositories.inMemoryRepo import MemoryBookRepo, MemoryClientRepo, MemoryRentRepo
from repositories.textFileRepo import TextBookRepo, TextRentRepo, TextClientRepo
from services.BookService import BookService
from services.ClientService import ClientService
from services.RentalService import RentalService
# from tests.ServiceTests import init_tests
from ui.menu import Menu
import configparser


def load_repo():
    settings = configparser.RawConfigParser()
    settings.read('settings.ini')
    books_file = settings.get('DEFAULT', 'books').replace('“', '').replace('”', '')
    clients_file = settings.get('DEFAULT', 'clients').replace('“', '').replace('”', '')
    rentals_file = settings.get('DEFAULT', 'rentals').replace('“', '').replace('”', '')

    if settings.get('DEFAULT', 'repository') == 'inmemory':
        return MemoryBookRepo(), MemoryClientRepo(), MemoryRentRepo()
    elif settings.get('DEFAULT', 'repository') == 'textfiles':
        return TextBookRepo(books_file), TextClientRepo(clients_file), TextRentRepo(rentals_file)
    elif settings.get('DEFAULT', 'repository') == 'binaryfiles':
        return BinaryBookRepo(books_file), BinaryClientRepo(clients_file), BinaryRentRepo(rentals_file)


if __name__ == '__main__':
    b_rep, c_rep, rent_rep = load_repo()

    b_service, c_service = BookService(b_rep), ClientService(c_rep, rent_rep, b_rep)

    r_service = RentalService(rent_rep, b_rep, c_rep)

    ui = Menu(b_service, c_service, r_service)

    # init_tests(b_service, c_service)

    ui.run_console()
