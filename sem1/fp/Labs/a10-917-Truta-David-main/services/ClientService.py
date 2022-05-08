import datetime
import random
import string

from domain.Entities import Client
from domain.Validators import ClientValidator
from repositories.IterableDS import IterableDataStructure
from services.UndoRedo import UndoManager, UndoHandler


class ClientService:
    def __init__(self, cl_repository, rental_repo, b_rep):
        self.__cl_repo = cl_repository
        self.__rental_repo = rental_repo
        self.__book_repo = b_rep

    def __create_id(self):
        # TODO update spec.
        """
        Computes a unique string formed by 10 randomly generated digits, which represents the client_id.
        :return: a string of 10 digits (client_id)
        """
        while True:
            id = ''.join(random.choice(string.digits) for _ in range(10))
            # id gets a randomly generated string formed by 10 digits
            if (id in self.get_all_clients()) is False:
                # if the randomly generated string is unique, it breaks the while loop
                break
        return id

    def default_clients(self, j):
        client_list = {'Marva Seabury', 'Jaqueline Bubb', 'Ayesha Lew', 'Ozell Peed', 'Angla Smoot',
                       'Irvin Bartow', 'Monet Leclaire', 'Gustavo Hambleton',
                       'Kera Lindeman', 'Cleveland Mcbath', 'Riva Ruiz', 'Yvonne Warshaw', 'Kristofer Mcbeath',
                       'Lyndon Colligan', 'Kacie Decarlo', 'Carissa Lokken', 'Ilana Gu', 'Sau Szymanski',
                       'Dacia Vanfleet', 'Mitzie Ospina'}
        i = 0
        while True:
            if (not client_list) or i == j:
                break
            cl_name = random.choice(list(client_list))
            i += 1
            client_list.remove(cl_name)
            self.add_client(cl_name)

    def add_client(self, name):
        """
        Creates a client object with a new ID and a name(param)
        :param name: (string) Name of the client
        :return: -
        Raises ClientValidatorException if client is not valid
        """
        c = Client(self.__create_id(), ' '.join(name.title().split()))
        ClientValidator.validate_client(c)
        self.__cl_repo.save_client(c)
        UndoManager.register_operation(self.__cl_repo, UndoHandler.ADD_CLIENT, c)

    def remove_client(self, id):
        client = self.find_clients(id)[0]
        self.__cl_repo.delete_client_id(id)
        rentals = self.__rental_repo.find_all_rentals()
        ch_rentals = []
        for rental in rentals:
            if rental.cl_id == id:
                if rental.returned_date == '-':
                    book = self.__book_repo.find_book_book_id(rental.book_id)
                    book.is_available = True
                    rental.returned_date = datetime.date.today()
                    ch_rentals.append(rental.id)
        UndoManager.register_operation(self.__cl_repo, UndoHandler.REMOVE_CLIENT, client, ch_rentals, self.__rental_repo,
                                       self.__book_repo)
        # TODO UNDO

    def update_client(self, id, name):
        c = Client(id, ' '.join(name.title().split()))
        ClientValidator.validate_client(c)
        client = self.find_clients(id)[0]
        self.__cl_repo.update_client(c)
        UndoManager.register_operation(self.__cl_repo, UndoHandler.UPDATE_CLIENT, client)

    def get_all_clients(self):
        return self.__cl_repo.find_all_clients()

    @staticmethod
    def acceptance_filter(client, arg):
        if arg in client.name.lower() or arg in client.id:
            return True
        return False

    def find_clients(self, arg):
        """
        Computes and returns a list of clients that include the given string(arg) in one of their fields.
        :param arg: a string, which represents a part of a field OR a field OF a client object.
        :return: list of clients
        Raises ValueError if no clients that match have been found
        """
        clients = self.get_all_clients()
        res = IterableDataStructure.filter(clients, self.acceptance_filter, arg)
        if not res:
            raise ValueError('No clients have been found!')
        return res

    def remove_all_clients(self):
        self.__cl_repo.delete_all_clients()
