<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8"/>
      <title>Get Book Highlights</title>
   </head>
   <body>
   <!-- Complete the URL -->
   
   <a href='showBooks.php?show=true'>Show Books you have read</a>
   <br><br>
   <a href='showBooks.php?howmany=true'>Show the no. of books you have read</a>
   <br><br>   
   <a href='showBooks.php?details=true'>Show the book details</a>
   <br><br>
   <!-- Add a link here to call your new function, bookDetails -->
  
<?php

if (isset($_GET['show'])) {
    showBooks();
}
elseif (isset($_GET['howmany'])) {
    howManyBooks();
}
elseif (isset($_GET['details'])) {
    bookDetails();
}
function showBooksWithHighLights(){
	
}
function howManyBooks(){
	//connect to your database. Type in your username, password and the DB path
	$conn=oci_connect('fkuan','ThisisUnsecure', '//dbserver.engr.scu.edu/db11g');
	if(!$conn) {
	     print "<br> connection failed:";       
        exit;
	}
	$query = oci_parse($conn, "SELECT bookcount from Dual");
	
	// Execute the query
	oci_execute($query);
	if (($row = oci_fetch_array($query, OCI_BOTH)) != false) {
		echo "You have read <font color='blue;font-size:20px'> $row[0] </font></br>";
	}
}
function showBooks(){
	//connect to your database. Type in your username, password and the DB path
	$conn=oci_connect('fkuan','ThisisUnsecure', '//dbserver.engr.scu.edu/db11g');
	if(!$conn) {
	     print "<br> connection failed:";       
        exit;
	}		
	$query = oci_parse($conn, "SELECT * FROM Books_read");
	
	// Execute the query
	oci_execute($query);
	while (($row = oci_fetch_array($query, OCI_BOTH)) != false) {		
		// We can use either numeric indexed starting at 0 
		// or the column name as an associative array index to access the colum value
		// Use the uppercase column names for the associative array indices		
		echo "<font color='green'> $row[0] </font></br>";
		echo "<font color='green'> $row[1] </font></br>";	
	}
	OCILogoff($conn);	
}

// Complete the function below as described on the assignment.
function  bookDetails(){
	//shows the title, author, category and highlights of the books	
	$conn=oci_connect('fkuan','ThisisUnsecure', '//dbserver.engr.scu.edu/db11g');
	if(!$conn) {
	     print "<br> connection failed:";       
        exit;
	}		
	$query = oci_parse($conn, "SELECT distinct title, author, category, highlight FROM Books_read Natural Join Book_Highlights");
	
	// Execute the query
	oci_execute($query);
	while (($row = oci_fetch_array($query, OCI_BOTH)) != false) {		
		// We can use either numeric indexed starting at 0 
		// or the column name as an associative array index to access the colum value
		// Use the uppercase column names for the associative array indices		
		echo '<br>';	
		echo "Title: <font color='green'> $row[0] </font></br>";
		echo "Author: <font color='green'> $row[1] </font></br>";
		echo "Category: <font color='green'> $row[2] </font></br>";
		echo "Highlight: <font color='green'> $row[3] </font></br>";	
	}
	OCILogoff($conn);	
}



?>
<!-- end PHP script -->
   </body>
</html>

