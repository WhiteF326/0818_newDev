<?php
  header("Content-Type: text/plain");

  $stagename = $_GET["name"];
  $path = "./../../stage/". strval($stagename). ".json";

  if (file_exists($path)) {
    header("HTTP/1.1 200 OK");
    echo file_get_contents($path);
  } else {
    header("HTTP/1.1 404 Not Found");
    echo $path;
  }
?>