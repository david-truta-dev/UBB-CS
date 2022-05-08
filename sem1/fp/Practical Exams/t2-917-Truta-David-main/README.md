# Petite Slam
Write a console-based, object-oriented Python application to help organize a tennis tournament in [knock-out format](https://en.wikipedia.org/wiki/Single-elimination_tournament). Each player has a unique **id**, a **name** and a **playing strength** (represented by an integer). Player data is read from a text file (you can use the example below). Your program will have to create player pairings for each round (starting with a possible qualifying round and up to the final), ask the user who won each game and update the winning player's strength after each game. The following features are required:
1. Display all players from the input file, sorted descending by playing strength **[1p]**. This can be done before starting the tournament.
2. Play the qualifying round **[2.5p]**. Only done when the number of players is not a power of two, and takes place as described at point 3 below. Let's look at some examples when having different numbers of players:
  - 5 players. One needs to be eliminated (tournament starts with semi-finals). In this case, the two players having the lowest playing strength play the qualification round (one game, winner joins the strongest 3 players in the semi-final).
  - 7 players. Three need to be eliminated (tournament starts with semi-finals). The qualification round has 3 games, played by the 6 players having the lowest playing strength. Pairings are established randomly. 
  - 13 players. Five need to be eliminated (tournament starts with quarter-finals). The qualification round has 5 games, played by the 10 players having the lowest playing strength. Pairings are established randomly.
3. Play the tournament. Each round takes place the following way:
  - Display a message informing the user about the current round (e.g. 'Last 4' in case of the semi-finals, 'Last 8' in case of the quarter-finals, 'qualification' in case of the qualifying round) **[0.5p]**.
  - Randomly pair the players still in the tournament.
  - Display the next game of the current round. Program will display the ids, names and updated playing strengths of the competing players. The user must enter the winner (e.g. enter 1 if first player won, 2 if second, or another way of your choice) **[2p]**.
  - Increase the playing strength of the winning player by 1 **[0.5p]**.
  - Tournament ends when the user enters the winner of the final (this is the tournament's last round) **[0.5p]**.

**Non-functional requirements:**
- Specification of the functions that create player pairings **[1p]**
- Code style (number and complexity of functions, parameter naming etc.) **[1p]**

**Default [1p]**

## Input file example 
100,Alice,45\
101,Bob,34\
102,Eve,68\
103,Carla,56\
104,James,55\
105,Johnny,33\
106,Miguel,36\
107,Robby,90\
108,Lawrence,89\
109,Hillary,88\
110,Terry,40\
111,Dave,60\
112,Andrea,59
