<?php

include "config.php";


$category_id = filterRequest("category_id"); 

$stmt = $con->prepare("SELECT * FROM `rental_items` Where `category_id` = ?");

$stmt->execute(array($category_id));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count= $stmt->rowCount();

if ($count>0) {
    echo json_encode(array("status" => "success", "data" =>$data));
}else{
    echo json_encode(array("status" => "fail"));
}

