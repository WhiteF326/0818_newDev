<?php
$username = "LAA1355306";
$database = "LAA1355306-proggame";
$password = "Fukui2021";
$dsn = "mysql:dbname=". $database. ";host=localhost";

$pdo = new PDO($dsn, $username, $password);

echo json_encode(
    $pdo->query(
        "insert into create_stages values (3, \"test\", 0, \"test\")"
    )
);