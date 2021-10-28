<?php
ini_set( 'display_errors', 1 );

require_once("./settings/env.php");

$prm = json_decode(file_get_contents("php://input"), true);

// var_dump($prm);

header("Content-type: text/plain; charset=UTF-8");

// db に繋ぐ
$username = "LAA1355306";
$database = "LAA1355306-proggame";
$password = $env["dbPassword"];
$dsn = "mysql:dbname=". $database. ";host=localhost";

$pdo = new PDO($dsn, $username, $password);

// パス取得
$path = $prm["path"];

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
          null, :uid, :stagename, :score, :cost, null, current_timestamp(), 0
        )";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":uid", $uid);
        $stm->bindValue(":stagename", $stageName);
        $stm->bindValue(":cost", $cost);
        $stm->bindValue(":score", $score);
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
        for($i = 0; $i < 100; $i++) {
          $upass = hash("sha512", $upass);
        }

        $sql = "insert into users values(
          :id, :name, :pass, 0, current_timestamp(),
          50, 50, 3
        )";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->bindValue(":name", $uname);
        $stm->bindValue(":pass", $upass);
        $stm->execute();
        $result = $stm->fetchAll(PDO::FETCH_ASSOC);
        var_dump($result);
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
        $uid = $prm["userid"];
        $sql = "select story_progress from users where id = :id";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->execute();
        $progress = $stm->fetchAll(PDO::FETCH_ASSOC);
        $stageNo = intval($progress[0]["story_progress"]) + 1;

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

        echo $progress[0]["story_progress"];
        break;
      }

      case "abort": {
        $uid = $prm["userid"];
        $sql = "select story_progress from users where id = :id";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->execute();
        $progress = $stm->fetchAll(PDO::FETCH_ASSOC);
        $progNo = $progress[0]["story_progress"];
        $sql = "update users set story_progress = ". (intval($progNo))
          . " where id = :id";
        $stm = $pdo->prepare($sql);
        $stm->bindValue(":id", $uid);
        $stm->execute();
        break;
      }
    }
    break;
  }
}
