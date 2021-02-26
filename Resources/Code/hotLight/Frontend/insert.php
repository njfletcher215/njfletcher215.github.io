<!DOCTYPE html>
<html lang=en>
<head>
	<Title>Send Form</Title>
</head>
<body>
	<?php
		echo "<h1>Insertion Status</h1>";

		// insert servername, username, password, and database you're using
		$servername = "SERVERNAME";
		$username = "USERNAME";
		$password = "PASSWORD";
		$dbname = "DATABASE";

		// connects specifically to dbname so we don't have to select a database later
		$conn = mysqli_connect($servername, $username, $password, $dbname);

		// test connection
    	if($conn === false){
	        die("ERROR: Could not connect. " . mysqli_connect_error());
		}

		// $_REQUEST['whatever'] has been passed in from index.php
		// mysqli_real_escape_string() prevents people from accidentally (or purposefully)
		// inserting as a value something that might be interpreted as code
       	$too_cold = mysqli_real_escape_string($conn, $_REQUEST['too_cold']);
    	$too_hot = mysqli_real_escape_string($conn, $_REQUEST['too_hot']);
		$bedtime = mysqli_real_escape_string($conn, $_REQUEST['bedtime']);

		// inserts $too_cold, $too_hot, $bedtime, and the current time (used to sort by recency)
    	$sql = "INSERT INTO temp_table VALUES ('$too_cold', '$too_hot', '$bedtime', NOW())";
    	if(mysqli_query($conn, $sql)){
        	echo "Records added successfully.";
    	} else{
    		echo "ERROR: Could not execute $sql. " . mysqli_error($conn);
    	}
	?>

	<a href="index.php">go back</a>

</body>
</html>
