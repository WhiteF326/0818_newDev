<?php
session_start();

require_once("./../../settings/env.php");
?>
<!DOCTYPE html>
<html lang="ja">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ゲーム画面</title>

  <script type="text/javascript" src="./../js/LoginCheck.js"></script>
</head>

<body>
  <p>ゲーム中</p>
  <?php
  $dsn = "mysql:dbname=LAA1355306-proggame;host=localhost";
  $user = "LAA1355306";
  $pass = $env["dbPassword"];
  try {
    $pdo = new PDO($dsn, $user, $pass);
    //sql文作成
    $sql = "SELECT story_progress FROM users
        WHERE id = :id";
    $stm = $pdo->prepare($sql);
    $stm->bindValue(":id", $_GET["userid"]);

    //sql実行
    $stm->execute();

    // 問題番号を取得
    $_SESSION["questionNo"] = $stm->fetchAll()[0]["story_progress"];
  } catch (PDOException $e) {
    echo $e->getMessage();
  }

  // クリア判定
  if ($_GET["clear"] == "yes") {
    $_SESSION["clear"] = true;
    $sql = "UPDATE users SET story_progress = " . ($_SESSION["questionNo"] + 1)
      . " where id = \"" . $_GET["userid"] . "\"";
    $pdo->query($sql);
  } else if($_GET["clear"] == "no"){
    $_SESSION["clear"] = false;
  } else{
    // continue
    $_SESSION["clear"] = true;
    $_SESSION["questionNo"]--;
  }

  // ユーザー情報を転送
  $_SESSION["userid"] = $_GET["userid"];
  // ヒントを転送
  $_SESSION["hinttext"] = $_GET["hinttext"];
  ?>
  <script>
    // 飛ばす
    window.location.href = "result.php";
  </script>
  <!-- <form action="result.php" method="POST">
    <input type="submit" name="true" value="正解">
    <input type="hidden" name="questionNo" value="<?php echo $questionNo; ?>">
  </form>
  <form action="result.php" method="POST">
    <input type="submit" name="false" value="不正解">
    <input type="hidden" name="questionNo" value="<?php echo $questionNo; ?>">
  </form> -->
</body>

</html>