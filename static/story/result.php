<?php
session_start();

require_once("./../../settings/env.php");

$questionflg = $_SESSION["clear"];
$userid = $_SESSION["userid"];

//正誤判定 正解ならtrue 不正解ならfalse
//$questionflg = false;

$questionNo = strval(intval($_SESSION["questionNo"]) + 1);
//データベースに接続
$serif = [];
//サーバーからセリフファイルを呼び出してstory.jsに送る
$dsn = "mysql:dbname=LAA1355306-proggame;host=localhost";
$user = "LAA1355306";
$pass = $env["dbPassword"];
try {
  $pdo = new PDO($dsn, $user, $pass);
  if ($questionflg == true) {
    //正解のとき
    //sql文作成
    $sql = "SELECT file,back_img FROM true_serif
            WHERE $questionNo = question_no";
    //sql実行
    $stmt = $pdo->query($sql);

    foreach ($stmt as $row) {
      $serif[] = explode(",", $row["file"]);
      $imgPath = $row["back_img"];
    }
  } else {
    //不正解のとき
    //sql文作成
    $sql = "SELECT file,back_img FROM false_serif
            WHERE $questionNo = question_no";
    //sql実行
    $stmt = $pdo->query($sql);

    foreach ($stmt as $row) {
      $serif[] = explode(",", $row["file"]);
      $imgPath = $row["back_img"];
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
  <script type="text/javascript" src="./../js/LoginCheck.js"></script>
</head>


<style>
  .modal {
    transition: 0.5s;
    opacity: 0;
    position: absolute;
    left: 0%;
    top: 0%;
    width: 100%;
    height: 100%;
    background-color: #f2feeeae;
    z-index: -1;
    text-align: center;
  }

  .center {
    color: #561f16;
    position: relative;
    top: 40%;
  }

  .hintbody {
    font-size: 1.2em;
  }
</style>

<body onload="message()" class="disparea">
  <div id="area">
    <canvas id="can" width="850" height="530"></canvas>
  </div>
  <div id="serifarea"></div>
  <div id="buttonarea"></div>
  <script>
    let mutedFlg = true;
    document.body.innerHTML += '<button id="toggleBGM">BGM を ON にする</button>';
    const tgl = document.getElementById("toggleBGM");
    const bgm = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/forest_ver2.mp3")
    bgm.volume = 0.166;
    tgl.onclick = () => {
      mutedFlg = !mutedFlg;
      tgl.innerText = mutedFlg ? "BGM を ON にする" : "BGM を OFF にする"
      if (!mutedFlg) {
        bgm.play();
      } else {
        bgm.pause();
      }
    }

    //キャンバスの作成
    let canvas = document.getElementById("can");
    let ctx = canvas.getContext("2d");

    //画像の取得
    let backImg = new Image();
    let youseiImg = new Image();
    let robotImg = new Image();
    let path = "<?php echo $imgPath; ?>";

    //パス設定
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
      backImg.src = path;
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
      backImg.src = path;
      youseiImg.src = "image/gakkusiyousei.png";
      ctx.drawImage(youseiImg, 400, 200, 450, 600);


      //ヒントボタンを作る
      const hbtn = document.createElement("button");
      hbtn.innerHTML = "ヒントを見る";
      hbtn.classList.add("hbtn");
      hbtn.onclick = function() {
        document.getElementById("modal").style.opacity = "1";
        document.getElementById("modal").style.zIndex = "1000";

        document.getElementById("hintText").innerText = <?= '"' . $_SESSION["hinttext"] . '"' ?>;

        document.getElementById("modal").onclick = () => {
          document.getElementById("modal").style.opacity = "0";
          document.getElementById("modal").style.zIndex = "-1";
        }
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

      } else if (string.indexOf("アンドロイド", 0) != -1) { //アンドロイドが喋っているとき
        //全体のcanvasを削除
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        //再描画
        ctx.drawImage(backImg, 0, 0, 850, 530);

        if (js_flg == "true") { //正解のとき 
          //表情を変えて再描画
          robotImg.src = "image/nikkorirobo.png";
          ctx.drawImage(robotImg, 0, 200, 450, 600);
        }

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

  ?>
    <form action="./../toStage.html" method="post">
      <input type="submit" value="次の問題へ" class="backBtn">
      <input type="hidden" name="questionNo" value="<?php echo $questionNo; ?>">
    </form>
  <?php } else {

  ?>
    <form action="./../toStage.html" method="post" class="formBtn">
      <input type="submit" value="問題に戻る" class="backBtn">
      <input type="hidden" name="questionNo" value="<?php echo $questionNo; ?>">
    </form>
  <?php } ?>
  <div class="modal" id="modal">
    <span class="center">ヒント：</span><br><br>
    <span class="center hintbody" id="hintText"></span><br><br><br>
    <span class="center">(画面をクリックすると閉じます)</span>
  </div>
</body>

</html>