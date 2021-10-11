<?php
require_once("./../../settings/env.php");
//セリフ入れる配列
$serif = [];
//セリフ番号
$serifId = 1;
//サーバーからセリフファイルを呼び出してstory.jsに送る
$username = "LAA1355306";
$database = "LAA1355306-proggame";
$password = $env["dbPassword"];
$dsn = "mysql:dbname=". $database. ";host=localhost";

$pdo = new PDO($dsn, $username, $password);
try {
  $pdo = new PDO($dsn, $username, $password);
  //sql文作成
  $sql = "SELECT serif_file FROM message
    WHERE $serifId = serif_id";
  //sql実行
  $stmt = $pdo->query($sql);

  foreach ($stmt as $row) {
    $serif[] = explode(",", $row["serif_file"]);
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
  <title>オープニング</title>
  <link rel="stylesheet" href="style.css">

</head>

<body>
  <div id="area">
    <canvas id="can" width="850" height="530"></canvas>
  </div>

  <br>

  <div id="serifarea"></div>
  <br>
  <button id="startBtn" onclick="message()">始める</button>
  <button onclick="skip()">オープニングをスキップする</button>
  <div id="nextarea"></div>

  <script>
    //キャンバスの作成
    const canvas = document.getElementById("can");
    const ctx = canvas.getContext("2d");
    ctx.fillStyle = "rgb(0,0,0)";
    ctx.fillRect(0, 0, 850, 530);
    ctx.font = "30px Arial";
    ctx.fillStyle = "rgb(255,255,255)";
    ctx.fillText("始めるボタンを押してストーリーを読んで下さい。", 0, 100);

    //画像の取得
    let backImg = new Image();
    let youseiImg = new Image();
    let robotImg = new Image();
    //パス設定
    backImg.src = "image/morigarakuta.png";
    youseiImg.src = "image/yousei.png";
    robotImg.src = "image/robo.png";


    //画像を読み込む前に描画しないようにloadイベントを行う
    /*backImg.onload = function() {
        //画像の描画
        ctx.drawImage(backImg, 0, 0, 850, 530);
    }

    robotImg.onload = function() {
        ctx.drawImage(robotImg, 0, 200, 450, 600);
    }

    youseiImg.onload = function() {
        ctx.drawImage(youseiImg, 400, 200, 450, 600);
    }*/


    //PHPから配列取ってくる
    let array = <?php echo $js_array; ?>;
    let speed = 100; //ミリ秒単位
    let string, char;
    let strlen = array[0].length - 1;
    let req;
    let i = 0;

    console.log(array[0]);

    function message() {
      //始めるボタンの無効化
      const startBtn = document.getElementById("startBtn");
      startBtn.disabled = true;

      //セリフ配列から一つ目のセリフを取り出す
      string = array[0].slice(0, 1).toString();
      array[0] = array[0].slice(1);

      message_char();

    }

    function message_char() {
      //console.log(i);
      //char = string.slice(0, i);
      //console.log(char);
      const serif = document.getElementById("serifarea");

      if (string.indexOf("妖精", 0) != -1) {
        //妖精が喋っているとき
        //全体のcanvasを削除
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        //再描画
        ctx.drawImage(backImg, 0, 0, 850, 530);
        ctx.drawImage(youseiImg, 400, 200, 450, 600);

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

      //セリフが最後まで終わっているか
      if (i <= string.length) {
        i++;
        Timer();
      } else { //終わったとき
        if (array[0].length == 0) {
          const next = document.getElementById("nextarea");
          const btn = document.createElement("button");
          btn.innerHTML = "ゲームスタート！";
          btn.onclick = function() {
            //ボタンが押された時
            localStorage.setItem("gameEnabled", "story");
            location = "./../toStage.html";
          };
          next.appendChild(btn);
          //console.log("終わり");
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

    //スキップしたいときの関数
    function skip() {
      localStorage.setItem("gameEnabled", "story");
      location = "./../toStage.html";
    }
  </script>
</body>

</html>