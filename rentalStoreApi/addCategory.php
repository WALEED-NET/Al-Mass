<?php

include "config.php";



$category_name = filterRequest("category_name");
$description = filterRequest("category_description");
$user_id = filterRequest("user_id");
// $user_id = /* Retrieve user ID from authentication */; // Assuming you have a mechanism to get the user ID



  // **WARNING: Storing passwords without hashing is a major security risk!**

  $stmt = $con->prepare("INSERT INTO `categories`(`name`, `description`, `user_id`) VALUES 
  (?,?,?)");
  $stmt->execute(array($category_name, $description, $user_id));

  $count = $stmt->rowCount(); // Assuming you want to check if the insert worked

  if ($count > 0) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "fail"));  // Might indicate a database issue
  }