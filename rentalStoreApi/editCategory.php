<?php

include "config.php";


// $category_id = filterRequest("category_id"); // Assuming category selection
$category_id = filterRequest("category_id"); 
$name = filterRequest("category_name");
$description = filterRequest("category_description");





$stmt = $con->prepare("UPDATE `categories` SET `name`=?,
`description`=? WHERE `category_id` = ? ");

$stmt->execute(array($name,$description, $category_id));

$count = $stmt->rowCount(); // Assuming you want to check if the insert worked

if ($count > 0) {
  echo json_encode(array("status" => "success"));
} else {
  echo json_encode(array("status" => "fail"));  // Might indicate a database issue
}