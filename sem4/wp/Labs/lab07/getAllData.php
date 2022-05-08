<?php

include("database.php");
$db=$conn;
// fetch query
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
  echo '<table>
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

  echo "<tr>
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
    echo "<tr>
          <td colspan='6'>No Data Found</td>
        </tr>"; 
  }
  echo "</table>";
}

?>