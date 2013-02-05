<?php
//PHP script to return all Theme names

//define variables for connecting to the database
$host = "ps11.pstcc.edu";
$user = "c2850a01";
$pass = "c2850a01";
$db = "c2850a01test";

//connect to the database
$connection = mysql_connect($host, $user, $pass) or die ('Error connection to MySQL');

mysql_select_db($db) or die ('Error selecting database');

$select_statement = "SELECT name FROM theme;";
$result = mysql_query($select_statement);
echo $result;

mysql_close($connection);

?>
