<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ゲーム画面</title>
</head>

<body>
    <p>ゲーム中</p>
    <?php
    if(isset($_POST["questionNo"])) {
        //
        $questionNo = $_POST["questionNo"];
        echo "現在　{$questionNo}問目";
    } else {
        $questionNo = 1;
        echo "現在　{$questionNo}問目";
    }
    ?>
    <form action="result.php" method="POST">
        <input type="submit" name="true" value="正解">
        <input type="submit" name="false" value="不正解">
        <input type="hidden" name="questionNo" value="<?php echo $questionNo; ?>">

    </form>
</body>

</html>