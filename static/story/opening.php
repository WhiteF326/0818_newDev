<?php
require_once("./../../settings/env.php");
$serif = []; //セリフ入れる配列
$serifId = 1; //セリフ番号
$faceNum = []; //表情数値

//データベースからセリフファイルを呼び出してstory.jsに送る
$username = "LAA1355306";
$database = "LAA1355306-proggame";
$password = $env["dbPassword"];
$dsn = "mysql:dbname=" . $database . ";host=localhost";

try {
  $pdo = new PDO($dsn, $username, $password);
  //sql文作成
  $sql = "SELECT serif_file,face_file,back_img FROM message
    WHERE $serifId = serif_id";
  //sql実行
  $stmt = $pdo->query($sql);

  foreach ($stmt as $row) {
    $faceNum[] = explode(",", $row["face_file"]);
    $serif[] = explode(",", $row["serif_file"]);
    $imgPath = $row["back_img"];
  }
} catch (PDOException $e) {
  echo $e->getMessage();
}


$serif_array = json_encode($serif);
$faceNum_array = json_encode($faceNum);

?>

<!DOCTYPE html>
<html lang="ja">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ストーリー</title>
  <link rel="stylesheet" href="style.css">

</head>

<body onload="message()">
  <div id="area">
    <canvas id="can" width="850" height="530"></canvas>
  </div>

  <br>

  <div id="serifarea"></div>
  <div class="Btnarea" id="nextarea">
    <button id="startBtn" onclick="message()" class="Btn_1">進む</button>
    <button onclick="skip()" class="Btn_2">ストーリーをスキップする</button>
  </div>

  <script>
    //キャンバスの作成
    const canvas = document.getElementById("can");
    const ctx = canvas.getContext("2d");

    //画像の取得
    let backImg = new Image();
    let youseiImg = new Image();
    let robotImg = new Image();
    let path = '<?php echo $imgPath; ?>';
    //console.log(typeof(path));

    //画像を読み込む前に描画しないようにloadイベントを行う
    backImg.onload = function() {
      //画像の描画
      ctx.drawImage(backImg, 0, 0, 850, 530);
    }
    backImg.src = path;

    youseiImg.onload = function() {
      ctx.drawImage(youseiImg, 400, 200, 450, 600);
    }
    youseiImg.src = "image/yousei.png";

    robotImg.onload = function() {
      ctx.drawImage(robotImg, 0, 200, 450, 600);
    }
    robotImg.src = "image/robo.png";

    /*ctx.fillStyle = "rgb(0,0,0)";
    ctx.fillRect(0,0,850,530);
    ctx.font = "30px Arial";
    ctx.fillStyle = "rgb(255,255,255)";
    ctx.fillText("ストーリーを読むには、進むボタンを押してください。", 10, 100);
    */

    //PHPから配列取ってくる
    let serif_array = <?php echo $serif_array; ?>;
    let face_array = <?php echo $faceNum_array; ?>;

    let speed = 100; //ミリ秒単位
    let string;
    let faceNum;
    let strlen = serif_array[0].length - 1;
    let i = 0; //セリフ位置

    //表情判定関数
    function faceJudge(num, name) {
      switch (num) {
        case "1": //表情:普通
          if (name == "妖精") {
            return "image/yousei.png";
          } else {
            return "image/robo.png";
          }
          break;
        case "2": //笑顔
          if (name == "妖精") {
            return "image/nikkoriyousei.png";
          } else {
            return "image/nikkorirobo.png";
          }
          break;
        case "3": //ビックリ
          if (name == "妖精") {
            return "image/bikkuriyousei.png";
          } else {
            return "image/bikkurirobo.png";
          }
          break;
        case "4": //ガッカリ
          if (name == "妖精") {
            return "image/gakkusiyousei.png";
          } else {
            return "image/gakkusirobo.png";
          }
          break;
        case "5": //怒り
          if (name == "妖精") {
            return "image/ikariyousei.png";
          } else {
            return "image/ikarirobo.png";
          }
          break;
      }

    }

    //セリフ切り取り関数
    function message() {

      //セリフ配列から一つずつ取り出す
      string = serif_array[0].slice(0, 1).toString();
      serif_array[0] = serif_array[0].slice(1);

      //表情配列から一つずつ取り出す
      faceNum = face_array[0].slice(0, 1).toString();
      face_array[0] = face_array[0].slice(1);

      message_char();

    }

    //セリフ表示関数
    function message_char() {
      const serif = document.getElementById("serifarea");

      if (string.indexOf("妖精", 0) != -1) {
        //妖精が喋っているとき
        youseiImg.src = faceJudge(faceNum, "妖精");
        //console.log();
        //全体のcanvasを削除
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        //再描画
        ctx.drawImage(backImg, 0, 0, 850, 530);
        ctx.drawImage(youseiImg, 400, 200, 450, 600);

      } else if (string.indexOf("アンドロイド", 0) != -1) {
        //アンドロイドが喋っているとき
        robotImg.src = faceJudge(faceNum, "アンドロイド");
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
        //Timer();
      } else { //終わったとき
        if (serif_array[0].length == 0) {
          serif.innerHTML = "スタートボタンを押すと、問題が始まります。";
          const next = document.getElementById("nextarea");
          const btn = document.createElement("button");
          btn.innerHTML = "スタート！";
          btn.onclick = function() {
            //ボタンが押された時
            location = "game.php";
          };
          next.appendChild(btn);

          //進むボタン無効化
          const startBtn = document.getElementById("startBtn");
          startBtn.disabled = true;
          return;

        }

        //clearTimeout(req);
        i = 1;
        message();
      }
    }

    /*function Timer() {
        req = setTimeout("message_char()", speed);
    }*/

    //スキップしたいときの関数
    function skip() {
      localStorage.setItem("gameEnabled", "story");
      location = "./../toStage.html";
    }
  </script>
</body>

</html>