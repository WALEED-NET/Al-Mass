<?php

$dsn = "mysql:host=localhost;dbname=rental_store_app";
$user = "root";
$password = "";
$option = array(
    PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES UTF8" // for enable arabic writing 
);

try {
  // PDO connection with UTF-8 encoding for Arabic characters
  $con = new PDO($dsn, $user, $password,$option);

  // Set error mode for exception handling
  $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    include "functions.php";

  // Your application logic using $con for database operations

} catch (PDOException $e) {
  echo "Database connection error: " . $e->getMessage();
}

?>
