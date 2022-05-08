class Player:

    def __init__(self, id, name, strength):
        self.__id = id
        self.__name = name
        self.__strength = strength

    @property
    def id(self):
        return self.__id

    @id.setter
    def id(self, value):
        self.__id = value

    @property
    def name(self):
        return self.__name

    @name.setter
    def name(self, value):
        self.__name = value

    @property
    def strength(self):
        return self.__strength

    @strength.setter
    def strength(self, value):
        self.__strength = value

    def __str__(self):
        return "ID: {:<5}   |  Name: {:<30}   |   Strength: {:<25} ".format(self.__id, self.__name, self.__strength)
