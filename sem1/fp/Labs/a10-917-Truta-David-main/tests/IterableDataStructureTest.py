from unittest import TestCase

from repositories.IterableDS import IterableDataStructure


class TestIDS(TestCase):
    def setUp(self):
        self.data = IterableDataStructure()
        self.data[0] = 1
        self.data[1] = 2
        self.data[2] = 3

    def test_iterable(self):
        c = 0
        for el in self.data:
            if c == 0:
                self.assertEqual(el, 1)
            elif c == 1:
                self.assertEqual(el, 2)
            elif c == 2:
                self.assertEqual(el, 3)
            c += 1

    def test_setitem(self):
        pass

    def test_delete(self):
        del self.data[2]
        self.assertEqual(len(self.data), 2)

    def test_get(self):
        number = self.data[2]
        self.assertEqual(number, 3)

    def test_pop(self):
        number = self.data.pop(2)
        self.assertEqual(number, 3)

    def test_values(self):
        data, c = list(self.data.values()), 0
        self.assertEqual(data[0], 1)
        self.assertEqual(data[1], 2)
        self.assertEqual(data[2], 3)

    def test_keys(self):
        data, c = list(self.data.keys()), 0
        self.assertEqual(data[0], 0)
        self.assertEqual(data[1], 1)
        self.assertEqual(data[2], 2)

    def test_clear(self):
        self.data.clear()
        self.assertEqual(len(self.data), 0)

    @staticmethod
    def acceptance_filter(element):
        if element == 2:
            return True
        return False

    def test_filter(self):
        lst = self.data.filter(list(self.data.values()), self.acceptance_filter)
        for i in lst:
            self.assertEqual(i, 2)

        del self.data[1]
        self.assertRaises(ValueError, self.data.filter, list(self.data.values()), self.acceptance_filter)

    @staticmethod
    def det_order(element):
        return element

    def test_gnome_sort(self):
        self.data[0] = 3
        self.data[1] = 2
        self.data[2] = 4
        self.data[3] = 1

        lst = self.data.gnome_sort(list(self.data.values()), self.det_order)
        self.assertEqual(lst[0], 1)
        self.assertEqual(lst[1], 2)
        self.assertEqual(lst[2], 3)
        self.assertEqual(lst[3], 4)

        lst = self.data.gnome_sort(list(self.data.values()), self.det_order, True)
        self.assertEqual(lst[0], 4)
        self.assertEqual(lst[1], 3)
        self.assertEqual(lst[2], 2)
        self.assertEqual(lst[3], 1)

        self.data.clear()
        lst = self.data.gnome_sort(list(self.data.values()), self.det_order)
        self.assertEqual(len(lst), 0)
