<?php

include("database.php");
$db=$conn;

$postdata = file_get_contents("php://input");

if(isset($postdata) && !empty($postdata))
{
  $request = json_decode($postdata);

  $id = (int)$request->idnews;
  $title = trim($request->title);
  $date = trim($request->date);
  $category = trim($request->category);
  $content = trim($request->text);
  $producer = (int)$request->idproducer;

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
}
?>