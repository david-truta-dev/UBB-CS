import random


class Tournament:
    def __init__(self, players):
        self.__repo = players

    def get_all_players(self):
        return self.__repo.get_all_players()

    @staticmethod
    def check_power_of_two(nr):
        while nr > 2:
            nr = nr/2
        if nr == 2:
            return True
        return False

    def how_many_to_eliminate(self):
        nr_players = len(self.__repo.get_all_players())
        nr = 1
        while nr < nr_players:
            nr *= 2
        if nr > nr_players:
            nr /= 2
        if (nr_players - nr) % 2 == 0:
            return nr_players - nr
        else:
            return nr_players - nr + 1

    def players_lowest_strength(self, nr):
        players = self.get_all_players()
        players_lower = []
        for i in range(nr):
            strength = 99999999
            low_player = None
            for player in players:
                if player.strength < strength:
                    strength = player.strength
                    low_player = player
            players.remove(low_player)
            players_lower.append(low_player)
        return players_lower

    @staticmethod
    def get_loser_strength(player1, player2):
        if player1.strength > player2.strength:
            return player2
        elif player1.strength == player2.strength:
            return None
        else:
            return player1

    def get_2_players(self, list):
        player1 = random.choice(list)
        player2 = random.choice(list)
        while player2 == player1:
            player2 = random.choice(list)
        return player1, player2

    def get_winner(self):
        return int(input('Give the id of the winner:').strip())

    def qualifying_round(self):
        nr_players = float(len(self.__repo.get_all_players()))
        while self.check_power_of_two(nr_players) is False:

            players_lowest_strength = self.players_lowest_strength(int(self.how_many_to_eliminate()))

            player1, player2 = self.get_2_players(players_lowest_strength)

            loser = self.get_loser_strength(player1, player2)
            players_lowest_strength.remove(loser)
            self.__repo.remove_player(loser.id)
            nr_players -= 1

    def play_tournament(self):
        while len(self.__repo.get_all_players()) > 1:
            print('\tLast', len(self.__repo.get_all_players()))
            player1, player2 = self.get_2_players(self.__repo.get_all_players())
            print('------ Round ------')
            print(player1, player2)
            winner_id = self.get_winner()
            winner = self.__repo.get_player_id(winner_id)
            if winner == player1:
                self.__repo.remove_player(player2.id)
            else:
                self.__repo.remove_player(player1.id)
            print('Winner:', winner)
            winner.strength += 1


    def start_tournament(self):
        self.qualifying_round()
        self.play_tournament()
