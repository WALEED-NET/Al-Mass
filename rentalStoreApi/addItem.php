<?php

include "config.php";


$category_id = filterRequest("category_id"); // Assuming category selection
$user_id = filterRequest("user_id"); 
$item_name = filterRequest("item_name");
$item_description = filterRequest("item_description");
$image = imageupload("image"); // Assuming image URL or path
$rental_price_per_day = filterRequest("rental_price_per_day");

// **WARNING: Storing passwords without hashing is a major security risk!**

$stmt = $con->prepare("INSERT INTO `rental_items`(`name`, `image`, `description`, `daily_rental_price`, `user_id`, `category_id`) 
VALUES (?,?,?,?,?,?)");
$stmt->execute(array($item_name, $image ,$item_description, $rental_price_per_day, $user_id, $category_id));

$count = $stmt->rowCount(); // Assuming you want to check if the insert worked

if ($count > 0) {
  echo json_encode(array("status" => "success"));
} else {
  echo json_encode(array("status" => "fail"));  // Might indicate a database issue
}