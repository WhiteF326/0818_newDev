<?php
$prm = json_decode(file_get_contents("php://input"), true);
$username = "LAA1355306";
$database = "laa1355306-proggame";
$password = getenv("dbPassword");
$dsn = "mysql:dbname=". $database. ";host=localhost";

$pdo = new PDO($dsn, $username, $password);

$uid = $prm["userid"];
$upass = utf8_encode($prm["password"]);
for($i = 0; $i < 100; $i++) {
  $upass = hash("sha512", $upass);
}
$sql = "select * from users where id = :id 
and pass = :pass";
$stm = $pdo->prepare($sql);
$stm->bindValue(":id", $uid);
$stm->bindValue(":pass", $upass);
$stm->execute();
$result = $stm->fetchAll(PDO::FETCH_ASSOC);

var_dump($result);
?>