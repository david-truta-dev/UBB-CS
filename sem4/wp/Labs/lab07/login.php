<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./login.css">
    <title>newsapp.com</title>
</head>
<body>
    <?php
        $usernameErr = $passwordErr = "";
        $username = $password = "";
        $loggedin = false;

        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            if (empty($_POST["username"])) {
                $usernameErr = "Username is required";
            } else {
                $username = $_POST["username"];
            }
            if (empty($_POST["password"])) {
                $passwordErr = "Password is required";
            } else {
                $password = $_POST["password"];
            }
            if(!empty($_POST["password"]) && !empty($_POST["username"])){
                redirect("./adminUserView.php");
            }
        }

        function redirect($url) {
            ob_start();
            header('Location: '.$url);
            ob_end_flush();
            die();
        }
    ?>
    <main id="loginForm">
        <h3>Log in:</h3>
        <form method="post" action="login.php">
            <div id="username">
                <label for="usernameInput">Username</label>
                <input id="usernameInput" type="text" name="username" value="<?php echo $username;?>">
                <span class="error"><?php echo $usernameErr;?></span>
            </div>
            <div id="password">
                <label for="passwordInput">Password</label>
                <input id="passwordInput" type="password" name="password" value="<?php echo $password;?>">
                <span class="error"><?php echo $passwordErr;?></span>
            </div>
            <button id="loginBtn">Log in</button>
        </form>
        <form action="normalUserView.html" method="post">
            <input type="submit" id="loggedoutBtn" name="goToNormalView" value="Continue without logging in">
        </form>
    </main>
</body>
</html>