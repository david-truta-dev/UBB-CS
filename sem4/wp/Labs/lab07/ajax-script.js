
let getAllData = function(){
    document.getElementById('activeFilters').innerHTML = "";
    $.ajax({    
      type: "GET",
      url: "getAllData.php",             
      dataType: "html",                  
      success: function(data){                    
          $("#tableContainer").html(data); 
      }
  });
}
$(document).on('click','#showData', getAllData);

$(document).on('click','#showFilteredData',function(){
    let startDate = $('#start').val();
    let endDate = $('#end').val();
    let category = $('#category').find(":selected").text();

    if(category == "----------------")
        document.getElementById('activeFilters').innerHTML = startDate + "\n" + endDate;
    else 
        document.getElementById('activeFilters').innerHTML = startDate + "\n" + endDate + "\n" + category;

    $.ajax({    
        type: "POST",
        url: "getFilteredData.php",             
        dataType: "json",
        data: ({start: startDate, end: endDate, category: category}),
        success: function(data){       
            $("#tableContainer").html(data); 
        }
    });

});

$(document).on('click','#addUpdateBtn',function(){
    let id = $('#newsId').val();
    let title = $('#titleInput').val();
    let date = $('#dateInput').val();
    let category = $('#categoryInput').find(":selected").text();
    let content = $('#contentInput').val();
    let producer = $('#prodId').val();

    $.ajax({    
        type: "POST",
        url: "addUpdate.php",             
        dataType: "json",
        data: ({id, title, date, category, content, producer}),
        success: function(data){
            getAllData();
        }
    }).done(function() { getAllData(); }).fail(
        function() { getAllData();}
    );
    
});

function login(){
    window.location.href = "./login.php";
}

function logout(){
    window.location.href = "./normalUserView.html";
}
