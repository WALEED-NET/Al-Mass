<?php

include "config.php";


// $userid = filterRequest("user_id");

// $stmt = $con->prepare("SELECT * FROM `categories` Where `user_id` = ?");

// $stmt->execute(array($userid));

// $data = $stmt->fetchAll(PDO::FETCH_ASSOC);

// $count= $stmt->rowCount();

// if ($count>0) {
//     echo json_encode(array("status" => "success", "data" =>$data));
// }else{
//     echo json_encode(array("status" => "fail"));
// }


// include "config.php";

$userid = filterRequest("user_id");

$stmt = $con->prepare("SELECT categories.*, COUNT(rental_items.category_id) AS item_count 
FROM categories 
LEFT JOIN rental_items ON categories.category_id = rental_items.category_id 
WHERE categories.user_id = ?
GROUP BY categories.category_id");

$stmt->execute(array($userid));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count = $stmt->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "fail"));
}
?>