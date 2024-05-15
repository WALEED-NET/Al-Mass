<?php

include "config.php";


$userid = filterRequest("user_id");

$stmt = $con->prepare("SELECT c.*, i.invoice_id, i.invoice_date, i.status, i.total_price
FROM customers c
JOIN invoices i ON c.customer_id = i.customer_id
WHERE c.user_id = ?");

$stmt->execute(array($userid));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count= $stmt->rowCount();

if ($count>0) {
    echo json_encode(array("status" => "success", "data" =>$data));
}else{
    echo json_encode(array("status" => "fail"));
}
