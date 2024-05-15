<?php

function filterRequest($requestname) {
  return trim(htmlspecialchars(strip_tags($_POST[$requestname])));
}

const MB = 1048576;


function imageupload($imagerequest){

  global $massageError;

  // the rand(1,100) is to choose random number and add it to the image name to make it uniqe
  $imagename = rand(1,100) . $_FILES[$imagerequest]["name"];
  $imagetmp = $_FILES[$imagerequest]["tmp_name"];
  $imagesize = $_FILES[$imagerequest]["size"];
  $allowExt = array("jpg", "png");

  // change the name of the image into an array : iamge.png => {image , png}
  $stringToAraary = explode(".", $imagename);

  // to take the last item of the array
  $ext = end($stringToAraary);

  // mybe the ext is captil latter like ' JPG' and we write in $allowExt 'jpg' and php case sentintive
  $ext = strtolower($ext);

  // to make sucre that there is file
  if (!empty($imagename) && !in_array($ext , $allowExt)) {
    $massageError[] = "Ext" ;
  }
  if ($imagesize > 2 * MB) {
    $massageError = "size" ;
  }

  if (empty($massageError)) {
     // take the image from the temp path into the path we want
  move_uploaded_file($imagetmp,"images/" . $imagename);
  // print_r($imagename);
  return $imagename;
  }else{
   

    return " fail";

    
  }
}

function deleteFile($dir , $imagename){
  if (file_exists($dir . "/" . $imagename)) {
    // for delete the file
    unlink($dir . "/" . $imagename);
  }
}