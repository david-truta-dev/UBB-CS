<?php

include("database.php");
$db=$conn;

$id = $_POST['id'];
$title = $_POST['title'];
$date = $_POST['date'];
$category = $_POST['category'];
$content = $_POST['content'];
$producer = $_POST['producer'];

// fetch query
function insert_data(){
 global $db, $id, $title, $date, $category, $content, $producer;

  $checkExists="SELECT * FROM news WHERE idnews='$id'";
  if(mysqli_num_rows(mysqli_query($db, $checkExists))>0){
    $query="UPDATE news SET title='$title', date='$date', category='$category', text='$content', idproducer='$producer' WHERE idnews='$id'";
    $exec = mysqli_query($db, $query);
  }
  else{
    $query="Insert into news(idnews, title, date, category, text, idproducer) values ('$id', '$title', '$date', '$category', '$content', '$producer')";
    $exec = mysqli_query($db, $query);
  }
  
}

insert_data();

?>