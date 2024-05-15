<?php

include "config.php";


$invoice_id = filterRequest("invoice_id");

$stmt = $con->prepare("SELECT (SUM(ri.daily_rental_price) * SUM(ii.quantity)) as total , ii.invoice_id 
FROM rental_items ri JOIN invoice_items ii ON ii.item_id = ri.item_id WHERE ii.invoice_id = ?;
");

$stmt->execute(array($invoice_id));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count= $stmt->rowCount();

if ($count>0) {
    echo json_encode(array("status" => "success", "data" =>$data));
}else{
    echo json_encode(array("status" => "fail"));
}
