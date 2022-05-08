<?php

include("database.php");
$db=$conn;

function fetch_data(){
 global $db;
  $query="SELECT * from news";
  $exec=mysqli_query($db, $query);
  if(mysqli_num_rows($exec)>0){
    $row= mysqli_fetch_all($exec, MYSQLI_ASSOC);
    return $row;  
        
  }else{
    return $row=[];
  }
}

$fetchData= fetch_data();
show_data($fetchData);

function show_data($fetchData){
  $news = [];
  if(count($fetchData)>0){
      $sn=0;
      foreach($fetchData as $data){ 
        $news[$sn]['idnews'] = $data['idnews'];
        $news[$sn]['title'] =  $data['title'];
        $news[$sn]['date'] =  $data['date'];
        $news[$sn]['category'] = $data['category'];
        $news[$sn]['text'] =  $data['text'];
        $news[$sn]['idproducer'] = $data['idproducer'];
        $sn++;
      }
  }
  echo json_encode(['data'=>$news]);
}

?>