<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8"/>
      <title>Get Employeee names</title>
   </head>
   <body>
<?php   
if ($_SERVER["REQUEST_METHOD"] == "POST") {

	// Get the different bracket of salaries
     	
	$salary = $_POST['salaries'];   
    
	if($salary == "50k"){
		$minSal = 50000;
	}elseif ($salary == "70k"){
		$minSal = 70000;
	}elseif ($salary == "90k"){
		$minSal = 90000;
	}elseif ($salary == "110k"){
		$minSal = 110000;
	}else{
		$minSal = 130000;
	}

	$maxSal = $minSal + 20000;

	//connect to your database.
	$conn=oci_connect('fkuan','ThisisUnsecure', '//dbserver.engr.scu.edu/db11g');
	if(!$conn) {
	     print "<br> connection failed:";       
        exit;
	}		
	$query = oci_parse($conn, "Select * from AlphaCoEmp where salary >= :min AND salary < :max");

	oci_bind_by_name($query, ':max', $maxSal);
	oci_bind_by_name($query, ':min', $minSal); 
	oci_execute($query);

	while (($row = oci_fetch_array($query, OCI_BOTH)) != false) {				
		echo '<br>';	
		echo "Name: <font color='green'> $row[0] </font></br>";
		echo "Title: <font color='green'> $row[1] </font></br>";
		echo "Salary: <font color='green'> $row[2] </font></br>";	
	}
	OCILogoff($conn);	
}
?>
</body>
</html>
