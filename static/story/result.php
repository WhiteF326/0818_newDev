<?php
session_start();

$questionflg = $_SESSION["clear"];
$userid = $_SESSION["userid"];

//正誤判定 正解ならtrue 不正解ならfalse
//$questionflg = false;

$questionNo = strval(intval($_SESSION["questionNo"]) + 1);
//データベースに接続
$serif = [];
//サーバーからセリフファイルを呼び出してstory.jsに送る
$dsn = "mysql:dbname=LAA1355306-proggame;localhost=3306";
$user = "LAA1355306";
$pass = "Fukui2021";
try {
  $pdo = new PDO($dsn, $user, $pass);
  if ($questionflg == true) {
    //正解のとき
    //sql文作成
    $sql = "SELECT file FROM true_serif
            WHERE $questionNo = question_no";
    //sql実行
    $stmt = $pdo->query($sql);

    foreach ($stmt as $row) {
      $serif[] = explode(",", $row["file"]);
    }

    $sql = "UPDATE users SET story_progress = $questionNo where id = \"$userid\"";
    $pdo->query($sql);
    $questionNo++;
    //print_r($serif);
  } else {
    //不正解のとき
    //sql文作成
    $sql = "SELECT file FROM false_serif
            WHERE $questionNo = question_no";
    //sql実行
    $stmt = $pdo->query($sql);

    foreach ($stmt as $row) {
      $serif[] = explode(",", $row["file"]);
    }
  }
} catch (PDOException $e) {
  echo $e->getMessage();
}

$js_array = json_encode($serif);
?>




<!DOCTYPE html>
<html lang="ja">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>result</title>
  <link rel="stylesheet" href="style.css">

</head>

<body onload="message()">
  <div id="area">
    <canvas id="can" width="850" height="530"></canvas>
  </div>
  <div id="serifarea"></div>
  <div id="buttonarea"></div>
  <script>
    //キャンバスの作成
    let canvas = document.getElementById("can");
    let ctx = canvas.getContext("2d");

    //画像の取得
    let backImg = new Image();
    let youseiImg = new Image();
    let robotImg = new Image();
    //パス設定
    backImg.src = "image/mori.png";
    youseiImg.src = "image/yousei.png";
    robotImg.src = "image/robo.png";


    //画像を読み込む前に描画しないようにloadイベントを行う
    /*backImg.onload = function() {
        //画像の描画
        ctx.drawImage(backImg, 0, 0, 850, 530);
        ctx.drawImage(robotImg, 0, 200, 450, 600);
        ctx.drawImage(youseiImg, 400, 200, 450, 600);

    }*/

    //phpから正誤判定のフラグ受け取り
    let js_flg = "<?php var_export((bool)$questionflg); ?>";

    const btnDiv = document.getElementById("buttonarea");
    if (js_flg == "true") { //正解のとき
      youseiImg.src = "image/nikkoriyousei.png";
      ctx.drawImage(youseiImg, 400, 200, 450, 600);

      //次へ進むボタン
      /*const btn = document.createElement("button");
      btn.innerHTML = "次へ進む";
      btn.onclick = function() {
          //
          location = "geme.php";
      };
      btnDiv.appendChild(btn);*/

    } else { //不正解のとき
      //表情変える
      youseiImg.src = "image/gakkusiyousei.png";
      ctx.drawImage(youseiImg, 400, 200, 450, 600);


      //ヒントボタンを作る
      const hbtn = document.createElement("button");
      hbtn.innerHTML = "ヒントを見る";
      hbtn.onclick = function() {
        //
        alert("ヒントです。");
      };
      btnDiv.appendChild(hbtn);

    }

    //phpからセリフの配列受け取り
    let array = <?php echo $js_array; ?>;
    let speed = 100; //ミリ秒単位
    let string, char;
    let req;
    let i = 0;

    function message() {
      //セリフ配列から一つ目のセリフを取り出す
      string = array[0].slice(0, 1).toString();
      array[0] = array[0].slice(1);

      message_char();

    }

    function message_char() {
      //console.log(i);
      //char = string.slice(0, i);
      //console.log(char);
      let serif = document.getElementById("serifarea");

      if (string.indexOf("妖精", 0) != -1) { //妖精が喋っているとき
        //全体のcanvasを削除
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        //再描画（背景）
        ctx.drawImage(backImg, 0, 0, 850, 530);

        if (js_flg == "true") { //正解のとき 
          //表情を変えて再描画
          youseiImg.src = "image/nikkoriyousei.png";
          ctx.drawImage(youseiImg, 400, 200, 450, 600);

        } else { //不正解のとき
          //表情を変えて再描画
          youseiImg.src = "image/gakkusiyousei.png";
          ctx.drawImage(youseiImg, 400, 200, 450, 600);
        }

      } else if (string.indexOf("アンドロイド", 0) != -1) {
        //アンドロイドが喋っているとき
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.drawImage(backImg, 0, 0, 850, 530);
        ctx.drawImage(robotImg, 0, 200, 450, 600);
      } else {
        //それ以外
        ctx.drawImage(backImg, 0, 0, 850, 530);
      }


      //セリフ表示
      serif.innerHTML = string;
      //}

      if (i <= string.length) {
        i++;
        Timer();
      } else {
        if (array[0].length == 0) {
          console.log("終わり");
          return;

        }
        clearTimeout(req);
        i = 1;
        message();
      }
    }

    function Timer() {
      req = setTimeout("message_char()", speed);
    }
  </script>
  <?php
  if ($questionflg == true) {
    //
  ?>
    <form action="http://localhost/static/toStage.html" method="post">
      <input type="submit" value="次の問題へ">
    </form>
  <?php } else {
    //
  ?>
    <form action="http://localhost/static/toStage.html" method="post">
      <input type="submit" value="問題に戻る">
    </form>
  <?php } ?>
</body>

</html>