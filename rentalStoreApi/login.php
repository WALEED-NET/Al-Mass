<?php

include "config.php";


$email = filterRequest("user_email");
$password = filterRequest("user_password");


$stmt = $con->prepare("SELECT * FROM `users` Where `email` = ? AND `password` = ? " );

$stmt->execute(array($email , $password));

$data = $stmt->fetchAll(PDO::FETCH_ASSOC);

$count= $stmt->rowCount();

if ($count>0) {
    echo json_encode(array("status" => "success", "data" =>$data));
}else{
    echo json_encode(array("status" => "fail"));
}



