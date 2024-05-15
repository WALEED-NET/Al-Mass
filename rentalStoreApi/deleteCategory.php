<?php

include "config.php";


$category_id = filterRequest("category_id");
// $imagename = filterRequest("imagename");

$stmt = $con->prepare("DELETE FROM `categories` Where `category_id` = ?");

$stmt->execute(array($category_id));


$count= $stmt->rowCount();

if ($count>0) {
    // deleteFile('images' , $imagename);
    echo json_encode(array("status" => "success"));
}else{
    echo json_encode(array("status" => "fail"));
}

