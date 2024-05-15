<?php

include "config.php";


// $category_id = filterRequest("category_id"); // Assuming category selection
$item_id = filterRequest("item_id"); 
$item_name = filterRequest("item_name");
$item_description = filterRequest("item_description");
$imagename = filterRequest("image"); // Assuming image URL or path
$rental_price_per_day = filterRequest("rental_price_per_day");

if (isset($_FILES['image'])) {
    
    deleteFile('/images' , $imagename);
    $imagename = imageupload("image");


}

// **WARNING: Storing passwords without hashing is a major security risk!**

$stmt = $con->prepare("UPDATE `rental_items` SET `name`=?,`image`=?,`description`=?,
`daily_rental_price`=? WHERE `item_id` = ? ");

$stmt->execute(array($item_name, $imagename ,$item_description, $rental_price_per_day, $item_id));

$count = $stmt->rowCount(); // Assuming you want to check if the insert worked

if ($count > 0) {
  echo json_encode(array("status" => "success"));
} else {
  echo json_encode(array("status" => "fail"));  // Might indicate a database issue
}