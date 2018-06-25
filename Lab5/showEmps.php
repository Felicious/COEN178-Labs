<?php
//connect to your database
// You must edit the line below to give your user name, password 
// and a correct path to your database

$conn=oci_connect('fkuan','ThisisUnsecure', '//dbserver.engr.scu.edu/db11g');
if(!$conn) {
	print "<br> connection failed:";       
	exit;
}
//Parse the SQL query
$query = oci_parse($conn, "SELECT name,title FROM AlphacoEmp Order by name");

// Execute the query
oci_execute($query);

// Prepare to display results
echo "<b>";

// Fetch each row. the first column is 0, then 1, etc.
while($row=oci_fetch_array($query)){
	// String compare
	if (strcmp($row[1],'advisor') == 0){
		echo "<font color='green'> $row[0] </font></br>";
	}
	else{
		echo "<font color='blue'> $row[0] </font></br>";
	}
}
echo "</b>";
// Log off
OCILogoff($conn);
?></html>
