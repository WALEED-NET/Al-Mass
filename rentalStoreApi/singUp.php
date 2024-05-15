<?php

include "config.php";
// include "functions.php";

// function filterRequest($requestname) {
//   return trim(htmlspecialchars(strip_tags($_POST[$requestname])));
// }


  $username = filterRequest('user_username');
  $email = filterRequest('user_email');
  $password = filterRequest('user_password');

  // **WARNING: Storing passwords without hashing is a major security risk!**

  $stmt = $con->prepare("INSERT INTO `users` (`name`, `email`, `password`) VALUES (?, ?, ?)");
  $stmt->execute(array($username, $email, $password));

  $count = $stmt->rowCount(); // Assuming you want to check if the insert worked

  if ($count > 0) {
    echo json_encode(array("status" => "success"));
  } else {
    echo json_encode(array("status" => "fail"));  // Might indicate a database issue
  }

?>
