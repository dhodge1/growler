<?php
//Comment change PHP script to return all theme names
$host = "ps11.pstcc.edu";
$user = "c2850a01";
$pass = "c2850a01";
$db = "c2850a01test";

//connect to the database
$connection = mysql_connect($host, $user, $pass) or die ('Error connection to MySQL');

mysql_select_db($db) or die ('Error selecting database');

$select_statement = "SELECT name FROM theme;";
$result = mysql_query($select_statement);
if (!$result) {
    $message  = 'Invalid query: ' . mysql_error() . "\n";
    $message .= 'Whole query: ' . $query;
    die($message);
}


//get the number of rows returned from the query
$num_rows = mysql_num_rows($result);

//process the result by fetching rows
for($i = 0; $i < $num_rows; $i++){
	//here we display what we get back from our query
        $row = mysql_fetch_row($result);
        echo "$row[0]<br/>";
}


mysql_close($connection);

?>
