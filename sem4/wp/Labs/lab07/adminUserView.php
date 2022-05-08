<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./adminUserView.css">
    <title>newsapp.com</title>
</head>
<body onload="getAllData()">

    <main>
        <nav id="navbarSection">
            <h1>This is my news app</h1>
            <button id="logOut" onclick="logout()">Log Out</button>
            <p> Admin User </p>
        </nav>
        <hr>
        <section id="crudSection">
            <h5>Add/Update a Row:</h5>
                <input id="newsId" type="number">
                <input id="titleInput" class="textInput" type="text">
                <input id="dateInput" type="date">
                <select name="category" id="categoryInput">
                    <option value="politics">politics</option>
                    <option value="society">society</option>
                    <option value="health">health</option>
                    <option value="sports">sports</option>
                </select>
                <input id="contentInput" class="textInput" type="text">
                <input id="prodId" type="number">
                <button id="addUpdateBtn">Add/Update</button>
        </section>
        <hr>
        <section id="newsSection">
            <div id="tableContainer"></div>
            <button id="showData">Show all the news</button>
        </section>
        <hr>
        <section id="filtersSection">
            <h5>Filter by date:</h5>
            <label for="start">Start date:</label>
            <input type="date" id="start" name="news-start"
            value="2000-01-01"
            min="2000-01-01" max="2100-01-01">
            <br>
            <label for="end">End date:</label>
            <input type="date" id="end" name="news-end"
            value="2023-01-01"
            min="2000-01-01" max="2100-01-01">
            <h5>Filter by category:</h5>
            <select name="category" id="category">
                <option value="noCategory">----------------</option>
                <option value="politics">politics</option>
                <option value="society">society</option>
                <option value="health">health</option>
                <option value="sports">sports</option>
            </select>
            <br>
            <button id="showFilteredData" >Show filtered news</button>
            <h5>Active Filters:</h5>
            <p id="activeFilters"></p>
        </section>
    </main>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="ajax-script.js"></script>
    
</body>
</html>