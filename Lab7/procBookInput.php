
<?php

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    
    // collect input data
	
	// Get the title
     $title = $_POST['title']; 
	 
	// Get the author	
     $author = $_POST['author']; 
	 
	 // Get the comments
	 $comments = $_POST['comments']; 
	 
      
     if (!empty($title)){
		$title = prepareInput($title);		
     } 
     if (!empty($author)){
		$author = prepareInput($author);		
     } 	 
	 if (!empty($comments)){
		$comments = prepareInput($comments);		
     } 	
	// Get the category
	$category = $_POST['category']; 

	$highlights = array();
	
	// Get the values for all selected checkboxes
	foreach($_POST['hlight'] as $check) {
          array_push($highlights,$check);  
    }
	// Call the function to insert title, author,category and comments
	// into Books_Read table
	
	insertBookInputIntoDB($title,$author,$category,$comments);
		
	// Call the function to insert title and book highlights
	// into Book_Highlights table
	
	insertBookHighLightsIntoDB($title,$highlights);
	
}
function prepareInput($inputData){
	$inputData = trim($inputData);
  	$inputData  = htmlspecialchars($inputData);
  	return $inputData;
}
function insertBookInputIntoDB($title,$author,$category,$comments){
	//connect to your database. Type in your username, password and the DB path
	$conn=oci_connect('fkuan','ThisisUnsecure', '//dbserver.engr.scu.edu/db11g');
	if(!$conn) {
	     print "<br> connection failed:";       
        exit;
	}		
	$query = oci_parse($conn, "Insert Into Books_Read(title,author,category,comments) values(upper(:title),upper(:author),:category,:comments)");	
	
	oci_bind_by_name($query, ':title', $title);
	oci_bind_by_name($query, ':author', $author);
	oci_bind_by_name($query, ':category', $category);
	oci_bind_by_name($query, ':comments', $comments);
	
	// Execute the query
	$res = oci_execute($query);
	if ($res)
		echo '<br><br> <p style="color:green;font-size:20px">Data successfully inserted</p>';
	else{
		$e = oci_error($query); 
        	echo $e['message']; 
	}
	OCILogoff($conn);	
}
function insertBookHighLightsIntoDB($title,$highlights){
	//connect to your database. Type in your username, password and the DB path
	$conn=oci_connect('fkuan','ThisisUnsecure', '//dbserver.engr.scu.edu/db11g');
	if(!$conn) {
	     print "<br> connection failed:";       
        exit;
	}	
	$query = oci_parse($conn, "Insert Into Book_HighLights(title,highlight) values(upper(:title),:highlight)");
	
	// $highlights is an array containing all the values
	// selected from the multiple checkboxes
	
	foreach ( $highlights as $oneHighlight ) {
		oci_bind_by_name($query, ':title', $title);
		oci_bind_by_name($query, ':highlight', $oneHighlight);
		// Execute the query
		oci_execute($query);
	}		

	OCILogoff($conn);	
}

?>

