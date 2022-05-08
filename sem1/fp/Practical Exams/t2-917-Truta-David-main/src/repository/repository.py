from domain.player import Player


class PlayerRepo:

    def __init__(self, file_name='input.txt'):
        self.__players = {}
        self.__file_name = file_name
        self.__load()

    def save_player(self, player):
        self.__players[player.id] = player

    def remove_player(self, id):
        self.__players.pop(id)

    def get_player_id(self, id):
        return self.__players[id]

    def get_all_players(self):
        return list(self.__players.values())

    def __load(self):
        f = open(self.__file_name, 'rt')  # read text
        lines = f.readlines()
        f.close()

        for line in lines:
            if line == '\n':
                break
            line = line.replace('\n', '').split(',')
            self.save_player(Player(int(line[0]), line[1], int(line[2])))