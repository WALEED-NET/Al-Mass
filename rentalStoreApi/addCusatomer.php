<?php

include "config.php";



  $username = filterRequest('customer_name');
  $phone_number = filterRequest('customer_phone_number');
  $address = filterRequest('customer_address');
  $user_id = filterRequest('customer_user_id');

  
  // Insert the customer record
  $stmt = $con->prepare("INSERT INTO `customers`(`name`, `phone_number`, `address`, `user_id`) VALUES (?,?,?,?)");
  $stmt->execute(array($username, $phone_number, $address, $user_id));
  
  $count = $stmt->rowCount(); // Assuming you want to check if the insert worked
  
  if ($count > 0) {
      // Retrieve the customer ID of the newly inserted record
      $customer_id = $con->lastInsertId();

      // echo $customer_id;

      // Insert the invoice record
      $stmt = $con->prepare("INSERT INTO `invoices`(`customer_id`,`user_id`) VALUES (?,?)");
      $stmt->execute(array( $customer_id, $user_id));

      // $stmt = $con->prepare("INSERT INTO `invoices`( `invoice_id`,`customer_id`, `invoice_date`, `status`, `total_price`, `user_id`) VALUES (?,?,?,?,?,?)");
      // $stmt->execute(array($invoice_id, $customer_id, $invoice_date, $status, $total_price, $user_id));
  
      $invoice_count = $stmt->rowCount(); // Assuming you want to check if the insert worked
  
      if ($invoice_count > 0) {
          echo json_encode(array("status" => "success"));
      } else {
          echo json_encode(array("status" => "fail")); // Might indicate a database issue
      }
  } else {
      echo json_encode(array("status" => "fail all")); // Might indicate a database issue
  }
  
