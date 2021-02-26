<!DOCTYPE=html>
<html lang=en>
<head>
  <title>Dev Tools</title>
</head>
<body>
  <h1>Temp over time</h1>

  <?php
    // insert servername, username, password, and database name for your MySQL database
    $servername = "SERVERNAME";
    $username = "USERNAME";
    $password = "PASSWORD";
    $dbname = "DATABASE";

    // Create connection
    // connects specifically to dbname, so we don't have to select a database later
    $conn = mysqli_connect($servername, $username, $password, $dbname);
    // Check connection
    if (!$conn) {
      die("Connection failed: " . mysqli_connect_error());
    }

    $sql = "SELECT time, temp FROM records";
    // this gives the command in sql to the database in conn
    $result = mysqli_query($conn, $sql);  // result will be the table we display

    if (mysqli_num_rows($result) > 0) {
      // set up a table and give it a heading
      echo "<table border='1px'>";
      echo "<tr><th>time</th><th>temp</th></tr>";
      while($row = mysqli_fetch_assoc($result)) { // fetch every row in the table as an associative array
	      echo "<tr>";  // start a new row
	      echo "<td>" . $row["time"]. "</td>";  // put the time in its own cell
	      echo "<td>" . $row["temp"]. "</td>";  // put the temp in its own cell
	      echo "</tr>";
      }
      echo "</table>";
    } else {  // if result is empty
      echo "0 results";
    }

    mysqli_close($conn);
  ?>

</body>
</html>
