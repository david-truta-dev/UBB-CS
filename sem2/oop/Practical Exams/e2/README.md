# Ethnographic Park
Write an application for the organisation of an ethnographic park. The park is rectangular in shape and is divided into square-shaped sectors. Sectors are identified using their row (`A, B, C, ...`) and column (`1, 2, 3, ...`) coordinates, with `A1` being the top left sector. The gift shop always takes up a single sector - the bottom rightmost one. The park in the picture below has 30 sectors; the gift shop is located at `E6`.

<img width="437" alt="park" src="https://user-images.githubusercontent.com/25611695/122884720-15fd6980-d347-11eb-8e63-7b758db92a94.png">

Your program must implement the following functionalities:
1. Information about **ethnologists** is read from a text file. Each ethnologist has a name and a thematic area (e.g. peasant workshops, botanical sector) they are responsible for.
2. Information about **buildings** is read from another text file. Each building has a unique identifier, a short description, the thematic area it belongs to and its location in the park, represented as a list of coordinates (e.g. `A3;A4;B3;B4`).
3. **[2p]** When the application is started, a new window is created for each ethnologist, having as title the ethnologist’s name and a random background color. The window will show information about all park buildings in a table, organized in the following way:
    * Each building is represented on a table row.
    * The table has four columns, one for each of building `id`, `description`, `thematic sector` and `location`.
    * Rows are sorted according to thematic area, with the topmost thematic area the one the ethnologist is responsible for.
    * The last thematic area is `office`, which only includes the gift shop building.
    * The buildings in the ethnologist's thematic area are displayed with a blue background.
4. **[2p]** An ethnologist can add a new building by entering its information into a number of text fields; the following constraints must be observed:
    * The new building's thematic area is automatically set to the one the ethnologist is responsible for.
    * Building identifiers are unique, and building descriptions cannot be empty.
    * Each building takes up at least one sector; buildings must be located over a set of continuous squares (e.g. `A5,A6,B6` are ok, but `A3,A4,B5` are not)
    * Building location sectors cannot overlap an existing building (e.g. you cannot have two buildings at `A2`).
5. **[1p]** Ethnologists can update the `description` and `location` of buildings in the thematic area they are responsible for.
6. **[2p]** When a modification is made by any ethnologist, all ethnologists see the updates automatically.
7. **[2p]** A separate window shows the ethnographic park's plan, as shown in the image above. Buildings are colored according to thematic area, using the background color of the corresponding ethnologist's window. This window is also updated when changes take place.

# Observations
    * Default 1p
    * You may use the `ethnologists.txt` and `buildings.txt` files as input; they should result in the building layout shown in the image above.
    * If you do not use layered architecture, your score is capped at 50% for each functionality.
    * If data is not read from files, your score is capped at 50% for functionalities 3, 4 and 5.
