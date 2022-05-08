from repository.repository import PlayerRepo
from services.tournament import Tournament
from ui.console import MainMenu

if __name__ == '__main__':
    repo = PlayerRepo()
    tournament = Tournament(repo)
    mm = MainMenu(tournament)
    mm.run()

