<?php
include "config.php";

// Assuming you have the invoice_id
$invoice_id = filterRequest("invoice_id"); // replace with your invoice_id

// Select the item_id and SUM of quantity from invoice_items for the specific invoice_id
$stmt = $con->prepare("SELECT `item_id`, SUM(`quantity`) as `quantity` FROM `invoice_items` WHERE `invoice_id` = ? GROUP BY `item_id`");
$stmt->execute(array($invoice_id));

$invoice_items = $stmt->fetchAll(PDO::FETCH_ASSOC); // Get all item_ids and quantities in an associative array

$data = array(); // Array to hold the rental items data

// Use the item_ids to select all matching rows from rental_items
foreach ($invoice_items as $invoice_item) {
    $stmt = $con->prepare("SELECT * FROM `rental_items` WHERE `item_id` = ?");
    $stmt->execute(array($invoice_item['item_id']));

    $rental_items = $stmt->fetchAll(PDO::FETCH_ASSOC); // Get all rental items in an associative array

    // Add the quantity to each rental item
    foreach ($rental_items as $rental_item) {
        $rental_item['quantity'] = $invoice_item['quantity'];
        $data[] = $rental_item;
    }
}

if (!empty($data)) {
    echo json_encode(array("status" => "success", "data" => $data));
} else {
    echo json_encode(array("status" => "fail"));
}
?>
