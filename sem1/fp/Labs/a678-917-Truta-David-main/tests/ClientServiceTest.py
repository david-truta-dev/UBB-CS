from unittest.case import TestCase

from repository.Repository import ClientRepo, RentRepo, BookRepo
from services.ClientService import ClientService


class ClientServiceTest(TestCase):

    def setUp(self):
        self._service = ClientService(ClientRepo(), RentRepo(), BookRepo(), 20)

    def test_find_client(self):
        # Testing for finding by name:
        res = self._service.find_clients('aquelin')
        self.assertEqual(res[0].name, 'Jaqueline Bubb')
        # Testing for finding by id:
        res1 = self._service.find_clients('va seabu')
        res2 = self._service.find_clients(res1[0].id)
        self.assertEqual(res2[0].name, 'Marva Seabury')
        # Testing it raises exception
        self.assertRaises(ValueError, self._service.find_clients, 'this shold not exist :)')
