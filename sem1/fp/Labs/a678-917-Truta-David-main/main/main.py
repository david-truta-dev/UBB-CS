from repository.Repository import BookRepo, ClientRepo, RentRepo
from services.BookService import BookService
from services.ClientService import ClientService
from services.RentalService import RentalService
from tests.ServiceTests import init_tests
from ui.menu import Menu

if __name__ == '__main__':

    b_rep, c_rep, rent_rep = BookRepo(), ClientRepo(), RentRepo()

    b_service, c_service = BookService(b_rep), ClientService(c_rep, rent_rep, b_rep)

    r_service = RentalService(rent_rep, b_rep, c_rep)

    ui = Menu(b_service, c_service, r_service)

    init_tests(b_service, c_service)

    ui.run_console()
