<?php
session_start();

if(!isset($_SESSION["tokens"])){
  $_SESSION["tokens"] = [];
}

ini_set( 'display_errors', 1 );

require_once("./settings/env.php");

$prm = json_decode(file_get_contents("php://input"), true);

// レスポンス header を定義
header("Content-type: text/plain; charset=UTF-8");

// db に繋ぐ
$username = "LAA1355306";
$database = "LAA1355306-proggame";
$password = $env["dbPassword"];
$dsn = "mysql:dbname=". $database. ";host=localhost";

$pdo = new PDO($dsn, $username, $password);

// パス取得
$path = $prm["path"];

// 時刻設定
date_default_timezone_set("Asia/Tokyo");

switch(explode("/", $path)[1]){
  case "":{
    break;
  }

  case "stage":{
    switch(explode("/", $path)[2]){
      case "select": {
        $stageName = $prm["name"];
        if(file_exists("./stage/". $stageName. ".json")){
          echo file_get_contents("./stage/". $stageName. ".json");
          break;
        }else{
          $first = array(
            "stage" => [
              [0, 0, 0],
              [0, 1, 0],
              [0, 0, 0]
            ],
            "param" => [
              [0, 0, 0],
              [0, 1, 0],
              [0, 0, 0]
            ],
            "start" => [1, 1, "right"],
            "goal" => [1, 1],
            "controll" => [0, 0],
            "costList" => [
              "move" => 3,
              "destroy" => 5,
              "create" => 5,
              "repair" => 10,
              "loop" => 1,
              "if" => 1
            ],
            "maxCost" => 10,
            "maxStep" => 10,
            "unlocked" => [
              "move",
              "destroy",
              "create",
              "repair",
              "loop",
              "if",
              "sensor_loop",
              "sensor_foot_dest",
              "sensor_foot_stab",
              "sensor_foot_floor",
              "sensor_foot_colp"
            ],
            "message" => ""
          );

          fwrite(
            fopen("./stage/". $stageName. ".json", "w"),
            json_encode($first)
          );
          echo json_encode($first);
          break;
        }
      }

      case "all":{
        $retAry = [];
        $stageList = glob("./stage/*");
        foreach($stageList as $stageName){
          array_push($retAry, intval(basename($stageName, ".json")));
        }
        sort($retAry);

        echo json_encode($retAry);
        break;
      }

      case "clear":{
        $uid = $prm["userid"];
        $stageName = $prm["stagename"];
        $cost = $prm["cost"];
        $score = $prm["score"];
        $sql = "insert into freemode_results values(
          null, :uid, :stagename, :score, :cost,
          :program, current_timestamp(), 0
        )";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":uid", $uid);
        $stm->bindValue(":stagename", $stageName);
        $stm->bindValue(":cost", $cost);
        $stm->bindValue(":score", $score);
        $stm->bindValue(":program", $prm["program"]);
        $result = $stm->execute();

        echo json_encode($result);
        break;
      }

      case "save":{
        $prmv = json_encode($prm["problem"]);
        fwrite(fopen("./stage/". $prm["name"]. ".json", "w"), $prmv);

        echo null;
        break;
      }
    }
    break;
  }

  case "user": {
    switch (explode("/", $path)[2]) {
      case "login": {
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

        if(count($result)){
          echo $result[0]["name"];
        }else{
          echo false;
        }
        break;
      }

      case "search": {
        $uid = $prm["userid"];
        $sql = "select * from users where id = :id";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->execute();
        $result = $stm->fetchAll(PDO::FETCH_ASSOC);

        if(count($result)){
          echo true;
        }else{
          echo false;
        }
        break;
      }

      case "register": {
        $uid = $prm["userid"];
        $uname = $prm["username"];
        $upass = utf8_encode($prm["password"]);
        $umail = $prm["email"];
        for($i = 0; $i < 100; $i++) {
          $upass = hash("sha512", $upass);
        }

        // メールアドレス 鍵の生成
        $method = "AES-256-CBC";
        $ivLength = openssl_cipher_iv_length($method);
        $iv = openssl_random_pseudo_bytes($ivLength);
        function concat($carry, $item){
          return $carry. $item;
        }
        $keyStr = array_reduce(
          array_fill(0, 16, base_convert(bin2hex(openssl_random_pseudo_bytes(16)), 16, 36)),
          "concat", ""
        );
        $key = substr($keyStr, 0, 256);
        $encrypted = openssl_encrypt($umail, $method, $key, 0, $iv);
        $saveObject = array(
          "email" => $encrypted,
          "key" => $key,
          "iv" => base64_encode($iv)
        );
        $saveClearText = json_encode($saveObject);
        $timeStamp = time();
        $civ = substr(date("Y-m-d H:i:s"), 0, $ivLength);
        $saveEncrypted = openssl_encrypt($saveClearText, $method, $key, 0, $civ);

        $sql = "insert into users values(
          :id, :name, :pass, 0, current_timestamp(),
          50, 50, 3, :mail, :key
        )";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->bindValue(":name", $uname);
        $stm->bindValue(":pass", $upass);
        $stm->bindValue(":mail", $saveEncrypted);
        $stm->bindValue(":key", $key);
        $stm->execute();
        $result = $stm->fetchAll(PDO::FETCH_ASSOC);
        echo null;
        break;
      }

      case "free": {
        $uid = $prm["userid"];
        $sql = "select * from freemode_results
          where userid = :id and deleted = 0";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->execute();
        $result = $stm->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($result);
        break;
      }

      case "reset": {
        $uid = $prm["userid"];
        switch (explode("/", $path)[3]) {
          case "free":{
            $sql = "update freemode_results set deleted = 1 where userid = :id";
            $stm = $pdo->prepare($sql);
            $stm->bindValue(":id", $uid);
            $stm->execute();

            echo null;
            break;
          }

          case "story":{
            $sql = "update users set story_progress = 0 where id = :id";
            $stm = $pdo->prepare($sql);
            $stm->bindValue(":id", $uid);
            $stm->execute();

            echo null;
            break;
          }
        }
      }

      case "settings": {
        $uid = $prm["userid"];
        switch (explode("/", $path)[3]) {
          // read
          case "read":{
            $sql = "select * from users where id = :id";
            $stm = $pdo->prepare($sql);
            $stm->bindValue(":id", $uid);
            $stm->execute();

            $result = $stm->fetchAll(PDO::FETCH_ASSOC);

            echo json_encode($result);
            break;
          }
        
          // write
          case "write":{
            $sql = "update users set
              sfx_volume = ". $prm["sfxVolume"]. ",".
              "bgm_volume = ". $prm["bgmVolume"]. ",".
              "gamespeed = ". $prm["gameSpeed"]. " where id = :id";
            $stm = $pdo->prepare($sql);
            $stm->bindValue(":id", $uid);
            $stm->execute();

            echo json_encode($result = $stm->fetchAll(PDO::FETCH_ASSOC));
            break;
          }
        }
      }
    }
    break;
  }

  case "story": {
    switch (explode("/", $path)[2]) {
      case "select": {
        $stageNo = intval($prm["stageNo"]);

        if(file_exists("./story/". $stageNo. ".json")){
          $ret = file_get_contents("./story/". $stageNo. ".json");
          echo $ret;
        }else{
          echo json_encode([]);
        }
        break;
      }

      case "getProgress": {
        $uid = $prm["userid"];
        $sql = "select story_progress from users where id = :id";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->execute();
        $progress = $stm->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($progress[0]["story_progress"]);
        break;
      }
    }
    break;
  }

  case "ranking": {
    switch (explode("/", $path)[2]) {
      case "user": {
        $uid = $prm["userid"];
        $stageNo = $prm["stageNo"] + 1;
        $sql = "select * from freemode_results
          where userid = :id and stagename = :stagename and score =
            (
              select max(score) from freemode_results
              where userid = :id and stagename = :stagename
              and date >= \"2021/10/29 11:04:00\"
              and deleted = 0
            )
          and date >= \"2021/10/29 11:04:00\"
          and deleted = 0
          order by cost asc, date desc
          ";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->bindValue(":stagename", $stageNo);
        $stm->execute();
        $result = $stm->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($result);
        break;
      }

      case "all": {
        $stageNo = $prm["stageNo"] + 1;
        $sql = "select max(score) as score from freemode_results
          where stagename = :stagename
          and date >= \"2021/10/29 11:04:00\"
          group by userid";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":stagename", $stageNo);
        $stm->execute();
        $result = $stm->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode($result);
        break;
      }
    break;
    }
  }

  case "recovery": {
    switch (explode("/", $path)[2]) {
      // 多分この処理遅い ごめんなさい
      case "search": {
        $queryValue = $prm["value"];
        $users = $pdo->query(
          "select id, update_time, mail_address, mail_key from users"
        )->fetchAll(PDO::FETCH_ASSOC);
        $method = "AES-256-CBC";
        $ivLength = openssl_cipher_iv_length($method);
        $hitEmail = false;
        $hitUser = false;
        forEach($users as $user){
          $decrypted = json_decode(
            openssl_decrypt(
              $user["mail_address"],
              $method,
              $user["mail_key"],
              0,
              substr($user["update_time"], 0, 16)
            ), true
          );
          $reDecrypted = openssl_decrypt(
            $decrypted["email"],
            $method,
            $decrypted["key"],
            0,
            base64_decode($decrypted["iv"])
          );
          if($reDecrypted == $queryValue){
            $hitEmail = $reDecrypted;
            $hitUser = $user["id"];
          }
          if($user["id"] == $queryValue){
            $hitEmail = $reDecrypted;
            $hitUser = $user["id"];
          }
        }
        if($hitEmail){
          // メールを送る、トークンを生成する
          $tokenLength = 32;
          $token = bin2hex(random_bytes($tokenLength));
          // token, expiration, email
          $expireDate = strtotime("+1 hour");
          array_push($_SESSION["tokens"], array(
            "token" => $token,
            "expire" => $expireDate,
            "email" => $hitEmail,
            "id" => $hitUser
          ));
          echo $token;
        }else{
          echo "Not Found";
        }
        break;
      }

      case "tokenRefresh": {
        while(count($_SESSION["tokens"])){
          if($_SESSION["tokens"][0]["expire"] < time()){
            array_shift($_SESSION["tokens"]);
          }
        }
        var_dump($_SESSION["tokens"]);
        break;
      }

      case "searchToken": {
        $token = $prm["token"];
        echo $_SESSION["tokens"][
          array_search($token, $_SESSION["tokens"])
        ]["email"];
        break;
      }

      case "resetPassword": {
        $token = $prm["token"];
        $upass = utf8_encode($prm["password"]);
        for($i = 0; $i < 100; $i++) {
          $upass = hash("sha512", $upass);
        }
        $id = $_SESSION["tokens"][
          array_search($token, $_SESSION["tokens"])
        ]["id"];
        $sql = "update users set pass = :pass where id = :id";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":pass", $upass);
        $stm->bindValue(":id", $id);
        $stm->execute();
        
        echo $id;
        break;
      }

      case "getTokenList": {
        var_dump($_SESSION["tokens"]);
        break;
      }
    }
    break;
  }

  case "create": {
    switch (explode("/", $path)[2]) {
      case "list": {
        $uid = $prm["userid"];
        $result = $pdo->query(
          "select * from create_stages where userid = \"". $uid. "\""
        )->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($result);
        break;
      }

      case "all": {
        $uid = $prm["userid"];
        // $result = $pdo->query(
        //   "select * from create_stages
        //   where not userid = \"". $uid. "\"
        //   and is_public = 1"
        // )->fetchAll(PDO::FETCH_ASSOC);
        $result = $pdo->query(
          "select * from create_stages"
        )->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($result);
        break;
      }

      case "search": {
        $stageid = $prm["stageid"];
        $uid = $prm["userid"];
        $result = $pdo->query(
          "select stagetext from create_stages
          where stageid = \"". $stageid. "\"
          and userid =\"". $uid. "\""
        )->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($result[0]["stagetext"]);
        break;
      }

      case "play": {
        $stageid = $prm["stageid"];
        $result = $pdo->query(
          "select stagetext from create_stages
          where stageid = \"". $stageid. "\""
        )->fetchAll(PDO::FETCH_ASSOC);
        echo json_encode($result[0]["stagetext"]);
        break;
      }

      case "clear": {
        $stageid = $prm["stageid"];
        $uid = $prm["userid"];
        $score = $prm["score"];
        $xml = $prm["program"];
        $sql = "insert into create_clear
        values(:userid, :stageid, :score, :program)";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":userid", $uid);
        $stm->bindValue(":stageid", $stageid);
        $stm->bindValue(":score", $score);
        $stm->bindValue(":program", $xml);
        $stm->execute();
        break;
      }

      case "update": {
        $stageid = $prm["stageid"];
        $stagetext = $prm["stagetext"];
        $uid = $prm["userid"];
        $sql = "update create_stages set stagetext = :stagetext, is_public = 0
          where stageid = :stageid and userid = :userid";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":stagetext", $stagetext);
        $stm->bindValue(":stageid", $stageid, PDO::PARAM_INT);
        $stm->bindValue(":userid", $uid);
        $stm->execute();
        echo null;
        break;
      }

      case "create": {
        $uid = $prm["userid"];
        if(isset($prm["stagetext"])){
          $stagetext = $prm["stagetext"];
        }else{
          $stagetext = file_get_contents("defaults/default.json");
        }
        $sql = "insert into create_stages values(:sid, :uid, 0, :stx)";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":sid", PDO::PARAM_NULL);
        $stm->bindValue(":uid", $uid);
        $stm->bindValue(":stx", $stagetext);
        $stm->execute();
        echo null;
        break;
      }

      case "delete": {
        $stageid = $prm["stageid"];
        $pdo->query(
          "delete from create_stages where stageid = \"". $stageid . "\""
        );
        echo null;
        break;
      }

      case "register": {
        $stageid = $prm["stageid"];
        $userid = $prm["userid"];
        $stagetext = $pdo->query(
          "select stagetext from create_stages
          where stageid = \"". $stageid. "\"
          and userid = \"". $userid. "\""
        )->fetchAll(PDO::FETCH_ASSOC)[0]["stagetext"];
        $hashedtext = hash("sha512", $stagetext, false);
        $pdo->query(
          "insert into create_testlist
          values(null, \"". $userid. "\", \"". $hashedtext. "\")"
        );
        echo null;
        break;
      }

      case "cleared": {
        $uid = $prm["userid"];
        $stagetext = $prm["stagetext"];
        $hashedtext = hash("sha512", $stagetext, false);
        $result = $pdo->query(
          "select * from create_testlist
          where userid = \"". $uid. "\"
          and hashed = \"". $hashedtext. "\""
        )->fetchAll(PDO::FETCH_ASSOC);
        if(count($result)){
          echo "true";
        }else{
          echo "false";
        }
        break;
      }

      case "publish": {
        $uid = $prm["userid"];
        $stageid = $prm["stageid"];
        $pdo->query(
          "update create_stages set is_public = 1
          where userid = \"". $uid. "\"
          and stageid = \"". $stageid. "\""
        );
        echo null;
        break;
      }

      case "favoritecount": {
        $stageid = $prm["stageid"];
        echo $pdo->query(
          "select count(*) as cnt from create_favorite
          where stageid = \"". $stageid. "\""
        )->fetchAll(PDO::FETCH_ASSOC)[0]["cnt"];
        break;
      }

      case "clearcheck": {
        $uid = $prm["userid"];
        $stageid = $prm["stageid"];
        echo $pdo->query(
          "select count(*) as cnt from create_clear
          where stageid = \"". $stageid. "\"
          and userid = \"". $uid. "\""
        )->fetchAll(PDO::FETCH_ASSOC)[0]["cnt"];
        break;
      }

      case "favoritecheck": {
        $uid = $prm["userid"];
        $stageid = $prm["stageid"];
        echo $pdo->query(
          "select count(*) as cnt from create_favorite
          where stageid = \"". $stageid. "\"
          and userid = \"". $uid. "\""
        )->fetchAll(PDO::FETCH_ASSOC)[0]["cnt"];
        break;
      }

      case "favorite": {
        $uid = $prm["userid"];
        $stageid = $prm["stageid"];
        $result = $pdo->query(
          "select count(*) as cnt from create_favorite
          where stageid = \"". $stageid. "\"
          and userid = \"". $uid. "\""
        )->fetchAll(PDO::FETCH_ASSOC)[0]["cnt"];

        if($result){
          $pdo->query(
            "delete from create_favorite
            where stageid = \"". $stageid. "\"
            and userid = \"". $uid. "\""
          );
        }else{
          $pdo->query(
            "insert into create_favorite
            values(\"". $uid. "\", \"". $stageid. "\")"
          );
        }
        break;
      }

      case "allfavorite": {
        echo json_encode(
          $pdo->query(
            "select stageid, count(*) as cnt from create_favorite
            group by stageid"
          )->fetchAll(PDO::FETCH_ASSOC)
        );
        break;
      }
    }
  }
}
