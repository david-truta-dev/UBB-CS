<?php

include("database.php");
$db=$conn;

$startDate = $_POST['start'];
$endDate = $_POST['end'];
$category = $_POST['category'];

// fetch query
function fetch_data(){
 global $db, $startDate, $endDate, $category;
    if ($category == "----------------"){
        $query="SELECT * from news WHERE ( date >= '$startDate' AND date <= '$endDate')";
    }else $query="SELECT * from news WHERE ( date >= '$startDate' AND date <= '$endDate' AND category ='$category')";
  
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
  $res = "";
  $res .= '<table>
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Date</th>
            <th>Category</th>
            <th>Text</th>
            <th>Producer</th>
        </tr>';
  if(count($fetchData)>0){
      $sn=1;
      foreach($fetchData as $data){ 

  $res.= "<tr>
          <td>".$sn."</td>
          <td>".$data['title']."</td>
          <td>".$data['date']."</td>
          <td>".$data['category']."</td>
          <td>".$data['text']."</td>
          <td>".$data['idproducer']."</td>
   </tr>";
       
  $sn++; 
     }
  } else{
    $res.= "<tr>
          <td colspan='6'>No Data Found</td>
        </tr>"; 
  }
  $res .= "</table>";

  echo json_encode($res);
}

?>