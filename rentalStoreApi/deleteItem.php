<?php

// include "config.php";


// $item_id = filterRequest("item_id");
// $imagename = filterRequest("imagename");

// $stmt = $con->prepare("DELETE FROM `rental_items` Where `item_id` = ?");

// $stmt->execute(array($item_id));


// $count= $stmt->rowCount();

// if ($count>0) {
//     deleteFile('images' , $imagename);
//     echo json_encode(array("status" => "success"));
// }else{
//     echo json_encode(array("status" => "fail"));
// }



include "config.php";


$item_id = filterRequest("item_id");
$imagename = filterRequest("imagename");

// Delete related invoice items first
$deleteRelatedStmt = $con->prepare("DELETE FROM invoice_items WHERE item_id = ?");
$deleteRelatedStmt->execute(array($item_id));

// Then delete the item itself
$stmt = $con->prepare("DELETE FROM `rental_items` Where `item_id` = ?");
$stmt->execute(array($item_id));


$count= $stmt->rowCount();

if ($count>0) {
  deleteFile('images' , $imagename);
  echo json_encode(array("status" => "success"));
}else{
  echo json_encode(array("status" => "fail"));
}



