<?php
  if(isset($_POST["name"])){
    $stagename = $_POST["name"].".json";
    if(file_exists($stagename)){
      $handle = fopen($stagename, "r");
      $resstr = "";
      while(!feof($handle)){
        $resstr = $resstr. fgets($handle);
      }
      header("HTTP/1.1 200 OK");
      header("Access-Control-Allow-Origin: *");
      echo $resstr;
    }else{
      header("HTTP/1.1 400 Bad Request");
    }
  }else{
    header("HTTP/1.1 405 Method Not Allowed");
  }
?>