<?php

include "config.php";


$invoice_id = filterRequest("invoice_id"); 
$invoice_date = filterRequest("invoice_date"); 
$status = filterRequest("status"); 
$total_price = filterRequest("total_price"); 



$stmt = $con->prepare("UPDATE `invoices` SET `invoice_date`=?,`status`=?,`total_price`=?
WHERE invoice_id = ? ");

$stmt->execute(array($invoice_id,$invoice_date,$status,$total_price));

$count = $stmt->rowCount(); // Assuming you want to check if the insert worked

if ($count > 0) {
  echo json_encode(array("status" => "success"));
} else {
  echo json_encode(array("status" => "fail"));  // Might indicate a database issue
}