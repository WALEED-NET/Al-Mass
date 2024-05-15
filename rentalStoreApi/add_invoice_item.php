<?php

include "config.php";

// Assuming you have a database connection established

// Get customer name and item ID from the request
$customer_name = filterRequest('customer_name');
$item_id = filterRequest('item_id');
$quantity = filterRequest('quantity'); // Assuming you receive the quantity as well

// Prepare the query to retrieve customer ID based on customer name
$customerQuery = "SELECT customer_id FROM customers WHERE name = ?";

// Prepare the statement with placeholder
$customerStmt = $con->prepare($customerQuery);

// Execute the statement with the customer name
$customerStmt->execute(array($customer_name));

// Check if customer found
if ($customerStmt->rowCount() > 0) {
  // Fetch the customer ID
  $customerRow = $customerStmt->fetch(PDO::FETCH_ASSOC);
  // $customer_id = $customerRow['customer_id'];
  $customer_id = $customerRow['customer_id'];

  // Proceed with retrieving invoice ID and inserting rental item

  // Prepare the query to retrieve invoice_id based on customer_id
  $query = "SELECT `invoice_id` FROM `invoices` WHERE `customer_id` = ?";

  // Prepare the statement with placeholder
  $stmt = $con->prepare($query);

  // Execute the statement with the customer_id
  $stmt->execute(array($customer_id));

  // Check if any invoice found for the customer
  if ($stmt->rowCount() > 0) {
    // Fetch the invoice_id
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    $invoice_id = $row['invoice_id'];

    // Prepare the query to insert rental item
    $insertQuery = "INSERT INTO invoice_items (item_id, invoice_id, quantity) VALUES (?, ?, ?)";

    // Prepare the statement with placeholders
    $insertStmt = $con->prepare($insertQuery);

    // Execute the insert statement with item_id, invoice_id, and quantity
    $insertStmt->execute(array($item_id, $invoice_id, $quantity));

    if ($insertStmt->rowCount() > 0) {
      // Success, rental item inserted
      // echo json_encode(array("status" => "success", "message" => "Rental item inserted successfully."));
      echo json_encode(array("status" => "success"));
    } else {
      // Error inserting rental item
      echo json_encode(array("status" => "fail", "message" => "Error inserting rental item: " .  implode(", ", $con->errorInfo())));
    }
  } else {
    // No invoice found for the customer
    echo json_encode(array("status" => "fail", "message" => "No invoice found for the given customer."));
  }
} else {
  // No customer found with the given name
  echo json_encode(array("status" => "fail", "message" => "No customer found with the given name."));
}

// Close the database connection
$con = null; // Assuming you use $con for your database connection

?>
