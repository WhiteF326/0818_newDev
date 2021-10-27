let moving = false;

import { fetchJSON } from './fetchP.js';
import { ResultScoreText } from './ResultScoreText.js';

class Body {
  constructor(mapinfo, settings, scoreTable) {
    // ユーザ設定の取得
    this.settings = settings;
    // マップ情報の取得
    this.mapinfo = mapinfo;
    this.map = this.mapinfo['stage'];
    this.mapY = this.map.length;
    this.mapX = this.map[0].length;
    this.param = this.mapinfo['param'];
    if (!this.param) {
      this.param = this.map;
      this.param = this.param.map(
        y => y.map(() => 0)
      );
    }
    this.start = this.mapinfo['start'];
    this.cstart = this.mapinfo['controll'];
    this.goal = this.mapinfo['goal'];
    this.costList = this.mapinfo['costList'];
    if (!this.costList) {
      this.costList = defaultCost;
    }
    this.goaled = false;
    this.lastStep = this.mapinfo['maxStep'];
    if (!this.lastStep) this.lastStep = defaultStep;
    document.getElementById("step").innerText =
      "残り歩数 : " + (this.lastStep - 1);
    document.getElementById("step").style.fontFamily = "cursive";
    document.getElementById("step").style.textShadow = "1px 1px 1px white";
    document.getElementById("step").style.color = "darkslategray";
    // スイッチ情報の管理
    this.doorPos = [[], [], [], [], []];
    let firstSwitchs = [0, 0, 0, 0, 0];
    for (let y = 0; y < this.mapY; y++) {
      for (let x = 0; x < this.mapX; x++) {
        if (this.map[y][x] === 5) firstSwitchs[this.param[y][x]]++;
        if (this.map[y][x] === 6) this.doorPos[this.param[y][x]] = [y, x];
      }
    }
    this.doors = new Doors(firstSwitchs);

    // 白キャラの初期位置と向きを設定
    this.currentY = this.start[0];
    this.currentX = this.start[1];
    this.currentVector = this.start[2];

    // カーソルの初期位置を設定
    this.cursorY = this.cstart[0];
    this.cursorX = this.cstart[1];
    this.futureCursorY = this.cstart[0];
    this.futureCursorX = this.cstart[1];

    // プログラム板の初期化
    this.progSize = this.mapinfo['progSize'];

    // ウィンドウサイズを取得
    this.sh = window.innerHeight;

    // tile size
    this.tilesize = min(
      64, floor(this.sh / 2.4 / Math.max(this.map.length, this.map[0].length)));

    // キャラ情報の取得
    this.charaAuto = new CharaAuto(this.start[2], this.tilesize, settings);
    this.charaHand = new CharaHand('right');
    this.endFlg = false;

    // キャラ描画用のフレーム値
    this.frame = 0;
    this.endFrame = 3;

    // チップ情報の取得
    this.chipList = new ChipList();

    // キャラ描画位置の調整
    this.charaAuto.setPos(
      this.currentY * this.tilesize,
      this.currentX * this.tilesize
      + this.charaAuto.getOffset(this.tilesize),
    );
    this.charaHand.setPos(
      this.cursorY * this.tilesize,
      this.cursorX * this.tilesize
      + this.charaHand.getOffset(this.tilesize),
    );

    // canvas設定
    this.canvas = document.getElementById('canvas');
    this.canvas.width = this.tilesize * this.map[0].length; // canvasの横幅
    this.canvas.height = this.tilesize * this.map.length; // canvasの縦幅

    this.canvas.oncontextmenu = () => false;

    // コンテキスト取得
    this.ctx = this.canvas.getContext('2d');
    this.ctx.font = "24px serif";
    this.ctx.fillStyle = "#FFD700";

    // 描画用関数の定義
    this.drawChip = (img, y, x) => {
      this.ctx.drawImage(
        img,
        0, 0,
        img.naturalWidth, img.naturalHeight,
        this.tilesize * x, this.tilesize * y,
        this.tilesize, this.tilesize,
      );
    };
    this.drawParam = (str, y, x) => {
      this.ctx.fillText(
        str,
        this.tilesize * x, this.tilesize * y + 20
      );
    };
    this.drawChar = (toDraw = this.charaAuto, frame) => {
      const drawAsset = toDraw.getAsset(frame);
      const size = toDraw.sizeExchange(this.tilesize);
      this.charaAuto.setVector(this.currentVector);
      this.ctx.drawImage(
        drawAsset['image'],
        drawAsset['positionX'], drawAsset['positionY'],
        toDraw.getcharaX(), toDraw.getcharaY(),
        toDraw.getposX(), toDraw.getposY(),
        size['x'], size['y'],
      );
    };

    this.maptileGoal = new Chip('./img/goal.png');

    this.progBoad = null;
    this.score = 0;
    this.scoreTable = scoreTable;

    this.render();
  }

  assignProgBoad = (progBoad) => {
    this.progBoad = progBoad;
  }

  cMove = (y, x) => {
    const dy = this.futureCursorY + y;
    const dx = this.futureCursorX + x;

    if (dy < 0 || dy >= this.mapY || dx < 0 || dx >= this.mapX) {
      return false;
    } else {
      this.futureCursorX += x;
      this.futureCursorY += y;
      this.charaHand.addMove(
        y * this.tilesize, x * this.tilesize
      );
      return true;
    }
  }
  cAction = (type) => {
    this.charaHand.addCursorAction(type);
    if (type === "create"
      && this.map[this.futureCursorY][this.futureCursorX] === 1) {
      this.map[this.futureCursorY][this.futureCursorX] = 10;
    }
  }

  sensor_foot = (targ) => {
    return contains(targ, this.map[this.futureCursorY][this.futureCursorX]);
  }

  destroyCursor = (y, x) => {
    if (this.map[y][x] === 2) {
      this.map[y][x] = 1;
      destroySound.currentTime = 0;
      destroySound.volume = 0.5 * this.settings["sfx_volume"] / 100;
      destroySound.play();
    }
  }
  createCursor = (y, x) => {
    if ((this.map[y][x] === 1 || this.map[y][x] === 10)
      && !(this.currentY === y && this.currentX === x)
      && !(this.goal[0] === y && this.goal[1] === x)) {
      console.log(y, x);
      this.map[y][x] = 2;
      putSound.currentTime = 0;
      putSound.volume = this.settings["sfx_volume"] / 100;
      putSound.play();
    }
  }
  repairCursor = (y, x) => {
    if (this.map[y][x] === 4) {
      this.param[y][x]++;
      repairSound.currentTime = 0;
      repairSound.volume = this.settings["sfx_volume"] / 100;
      repairSound.play();
    }
  }

  turnMoving = () => {
    moving = !moving;
  }

  render() {
    // キャラクターの移動
    this.frame++;
    if (this.frame === 4 << this.endFrame) this.frame = 0;
    for (let y = 0; y < this.map.length; y++) {
      for (let x = 0; x < this.map[y].length; x++) {
        // render chip
        this.drawChip(
          this.chipList.getChip(this.map[y][x], this.param[y][x]),
          y, x
        );
        if (y === this.goal[0] && x === this.goal[1]) {
          this.drawChip(this.maptileGoal, y, x);
        }

        // render param
        this.drawParam(
          this.chipList.printParam[this.map[y][x]](this.param[y][x]),
          y, x
        );
      }
    }
    this.drawChar(this.charaAuto, this.frame >> this.endFrame);
    this.drawChar(this.charaHand, this.frame >> this.endFrame);
    const stepSpend = this.charaAuto.moveFrame(
      Math.pow(2, Number(this.settings["gamespeed"]) - 1)
    );
    if (stepSpend) {
      this.lastStep--;
      if (this.lastStep <= 11) {
        document.getElementById("step").style.color = "crimson";
      }
      if (!this.lastStep) {
        const modal = document.getElementsByClassName("fmodalback")[0];
        modal.style.transition = "1s";
        modal.style.width = "85%";
        moving = false;
      }
    }
    const action = this.charaHand.moveFrame(
      Math.pow(2, Number(this.settings["gamespeed"]) - 1)
    );
    if (typeof action === "string") {
      const y = this.cursorY, x = this.cursorX;
      if (action === "create") {
        this.createCursor(y, x);
      } else if (action === "destroy") {
        this.destroyCursor(y, x);
      } else if (action === "repair") {
        this.repairCursor(y, x);
      }
    } else if (action) {
      this.cursorY += action[1];
      this.cursorX += action[0];
    }

    if (this.endFlg
      && this.charaHand.isWaitFor()
      && !this.goaled && this.lastStep) {
      moving = true;
    }

    if (this.currentY === this.goal[0] && this.currentX === this.goal[1] &&
      this.charaAuto.isWaitFor() && moving) {
      moving = false;
      this.goaled = true;
      const modal = document.getElementsByClassName("modalback")[0];
      modal.style.transition = "1s";
      modal.style.width = "85%";
      // 残り歩数
      const lastStep = this.lastStep - 1;
      // 残りコスト
      const lastCost = this.progBoad.calculateLastCost();
      // ブロック数 * 3 の減点
      const progXML = this.progBoad.getXML();
      let baseArr = [];
      for (let i = 0; i < progXML.length; i++) {
        baseArr[i] = i;
      }
      const blockCnt
        = baseArr.map(i => progXML.substr(i, 6) === "/block")
          .reduce((a, b) => a + b) - 1;
      // destroy, create, repair
      const dcrCnt
        = baseArr.map(i => {
          if (
            progXML.substr(i, 7) === "destroy"
            || progXML.substr(i, 6) === "create"
            || progXML.substr(i, 6) === "repair"
          ) {
            return 1;
          } else {
            return 0;
          }
        }).reduce((a, b) => a + b);
      const repeatSum
        = Array.from(
          new DOMParser().parseFromString(progXML, "text/xml")
            .getElementsByName("REPEATAMOUNT")
        ).map(r => Number(r.innerHTML))
          .reduce((a, b) => (a + b));
      // スコア
      this.score = lastStep * lastCost - 3 * blockCnt - dcrCnt - repeatSum;
      // スコア計算式を表示
      document.getElementById("scoreFormula").innerText = "";
      if (localStorage.getItem("gameEnabled") === "free") {
        const formula = document.getElementById("scoreFormula");
        formula.appendChild(
          ResultScoreText(
            lastStep, lastCost, blockCnt, dcrCnt, repeatSum, this.scoreTable
          )
        );
      }
    }

    if (moving) {
      document.getElementById("step").innerText =
        "残り歩数 : " + (this.lastStep - 1);
      const power = moveWay[this.currentVector]['power'];
      const dy = this.currentY + power[0];
      const dx = this.currentX + power[1];
      if (dy < 0 || dy >= this.mapY || dx < 0 || dx >= this.mapX) {
        this.currentVector = moveWay[
          moveWay[this.currentVector]['rt']
        ]['rt'];
      } else {
        const nex =
          this.map[this.currentY + power[0]][this.currentX + power[1]];
        const np =
          this.param[this.currentY + power[0]][this.currentX + power[1]];
        if (this.charaAuto.isWaitFor()) {
          if (!this.charaAuto.isJunping) {
            this.param[this.currentY][this.currentX]
              = this.chipList.stepFunc[this.map[this.currentY][this.currentX]]
                (this.param[this.currentY][this.currentX]);
          }
          if (this.map[this.currentY][this.currentX] === 5) {
            this.map[this.currentY][this.currentX] = 7;
            if (this.doors.pushed(
              this.param[this.currentY][this.currentX], this.settings
            )) {
              const doorNo = this.param[this.currentY][this.currentX];
              if (this.doorPos[doorNo].length) {
                this.map[this.doorPos[doorNo][0]][this.doorPos[doorNo][1]] = 8;
              }
            }
          }
          if ((nex === 4 && np >= 1) || contains([1, 5, 7, 8, 9], nex)) {
            this.currentY += power[0];
            this.currentX += power[1];
            this.charaAuto.addMove(
              power[0] * this.tilesize, power[1] * this.tilesize, false
            );
          } else if (nex === 3) {
            const jy = this.currentY + power[0] * 3;
            const jx = this.currentX + power[1] * 3;
            let jnex = 0;
            try {
              jnex = contains(floorList, this.map[jy][jx]);
            } catch (e) {
              jnex = 0;
            }
            if (jnex) {
              this.currentY += power[0] * 2;
              this.currentX += power[1] * 2;
              this.charaAuto.addMove(
                power[0] * this.tilesize * 2, power[1] * this.tilesize * 2, true
              );
            } else if (contains(floorList, nex)) {
              this.currentY += power[0];
              this.currentX += power[1];
              this.charaAuto.addMove(
                power[0] * this.tilesize, power[1] * this.tilesize, false
              );
            }
          } else {
            const leftWay = moveWay[this.currentVector]['lt'];
            const lnex =
              this.map
              [this.currentY + moveWay[leftWay]['power'][0]]
              [this.currentX + moveWay[leftWay]['power'][1]];
            const lprm =
              this.param
              [this.currentY + moveWay[leftWay]['power'][0]]
              [this.currentX + moveWay[leftWay]['power'][1]];
            const rightWay = moveWay[this.currentVector]['rt'];
            const rnex =
              this.map
              [this.currentY + moveWay[rightWay]['power'][0]]
              [this.currentX + moveWay[rightWay]['power'][1]];
            const rprm =
              this.param
              [this.currentY + moveWay[rightWay]['power'][0]]
              [this.currentX + moveWay[rightWay]['power'][1]];
            const bnex =
              this.map
              [this.currentY + moveWay[moveWay[rightWay]['rt']]['power'][0]]
              [this.currentX + moveWay[moveWay[rightWay]['rt']]['power'][1]];
            const bprm =
              this.param
              [this.currentY + moveWay[moveWay[rightWay]['rt']]['power'][0]]
              [this.currentX + moveWay[moveWay[rightWay]['rt']]['power'][1]];
            // left and right?
            if ((contains(floorList, lnex) || (lnex === 4 && lprm !== 0))
              && (contains(floorList, rnex) || (rnex === 4 && rprm !== 0))) {
              switch (routineAutoTwoWay) {
                case 'right':
                  this.currentVector = rightWay;
                  break;

                case 'left':
                  this.currentVector = leftWay;
                  break;
              }
            } else if (contains(floorList, lnex)
              || (lnex === 4 && lprm !== 0)) {
              this.currentVector = leftWay;
            } else if (contains(floorList, rnex)
              || (rnex === 4 && rprm !== 0)) {
              this.currentVector = rightWay;
            } else if (contains(floorList, bnex)
              || (bnex === 4 && bprm !== 0)) {
              this.currentVector = moveWay[rightWay]['rt'];
            } else {
              moving = false;
              setInterval(() => {
                const modal = document.getElementsByClassName("fmodalback")[0];
                modal.style.transition = "1s";
                modal.style.width = "85%";
              }, 1000)
            }
          }
        }
      }
    }
    requestAnimationFrame(this.render.bind(this));
  }
}

window.onload = async () => {
  if (localStorage.getItem("gameEnabled") === "false"
    || !localStorage.getItem("gameEnabled")) {
    history.back();
  }

  if (localStorage.getItem("gameEnabled") === "story") {
    document.getElementById("retry").remove();
  } else {
    document.getElementById("retry").addEventListener("click", () => {
      progBoad.save();
      location.reload();
    });
  }

  const mapinfo = localStorage.getItem("gameEnabled") === "free" ?
    JSON.parse(
      await fetchJSON('api/stage/select', {
        'name': localStorage.getItem("selectedStage")
      })
    ) : JSON.parse(
      await fetchJSON('api/story/select', {
        "userid": localStorage.getItem("userid")
      })
    );
  if (!(Object.keys(mapinfo).length)) {
    window.location.href = "betaEnd.html";
  }
  const settings = JSON.parse(await fetchJSON("api/user/settings/read", {
    "userid": localStorage.getItem("userid"),
  }))[0];
  const scoreTable = await (await fetch("./ScoreTable.html")).text();
  console.log(scoreTable)
  const gameBody = new Body(mapinfo, settings, scoreTable);

  const progBoad = new ProgBoad(gameBody);
  gameBody.assignProgBoad(progBoad);
  const stageNo = localStorage.getItem("selectedStage");
  if (localStorage.getItem("savedProgram" + stageNo)
    && localStorage.getItem("gameEnabled") === "free") {
    progBoad.loadFromText(localStorage.getItem("savedProgram" + stageNo));
  }

  window.onbeforeunload = () => {
    progBoad.save();
  }

  const modal = document.getElementsByClassName("modalback")[0];
  modal.addEventListener("click", async () => {
    modal.setAttribute("style", "width: 0%");
    modal.style.fontSize = "0px";
    if (localStorage.getItem("gameEnabled") === "free") {
      document.getElementsByClassName("scoreTable")[0].style.fontSize = "0px";
      document.getElementsByClassName("scoreTable")[0].style.opacity = "0%";
      document.getElementById("yj").style.width = "0";
      await fetchJSON("api/stage/clear", {
        "userid": localStorage.getItem("userid"),
        "stagename": localStorage.getItem("selectedStage"),
        "cost": progBoad.costCalculate(),
        "score": gameBody.score
      });
      setInterval(() => {
        window.location.href = "freeStageSelect.html";
      }, 1000);
    } else {
      setInterval(() => {
        window.location.href = "./story/game.php?" +
          "clear=yes&userid=" + localStorage.getItem("userid") +
          "&hinttext=none";
      }, 1000);
    }
  });

  const fmodal = document.getElementsByClassName("fmodalback")[0];
  fmodal.addEventListener("click", async () => {
    fmodal.setAttribute("style", "width: 0%");
    if (localStorage.getItem("gameEnabled") === "free") {
      setInterval(() => {
        window.location.href = "freeStageSelect.html";
      }, 1000);
    } else {
      setInterval(() => {
        window.location.href = "./story/game.php?" +
          "&clear=no&userid=" + localStorage.getItem("userid") +
          "&hinttext=" + encodeURIComponent(mapinfo["hint"]);
      }, 1000);
    }
  });

  const smodal = document.getElementsByClassName("smodal")[0];
  const smodalback = document.getElementsByClassName("smodalback")[0];
  if (localStorage.getItem("gameEnabled") === "free") {
    const stageNo = Number(localStorage.getItem("selectedStage"));
    const titleText = document.createElement("h2");
    titleText.innerText = (
      String(Math.floor((stageNo - 1) / 8) + 1) + "-"
      + String(stageNo % 8 !== 0 ? stageNo % 8 : 8)
    );
    smodal.appendChild(titleText);
  } else {
    smodalback.style.backgroundColor = "rgba(220, 249, 231, 0.94)"
    smodal.style.color = "#511341"
    const stageNo = Number(mapinfo["level"]);
    const titleText = document.createElement("h2");
    titleText.innerText = "ステージ" + stageNo;
    smodal.appendChild(titleText);
  }
  const frontText = mapinfo["message"] || "Not yet";
  smodal.appendChild(
    document.createTextNode(frontText)
  );
  setTimeout(() => {
    smodalback.style.height = "100%";
    smodalback.style.transform = "translateY(0%)";
    smodal.style.transform = "translateY(calc(50% + 250px))";

    const bgm = new Audio(
      "https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/"
      + (mapinfo["bgm"] || "forest_ver2") + ".mp3"
    );
    bgm.volume = settings["bgm_volume"] / 300;
    bgm.loop = true;
    bgm.play();
  }, 100);

  smodalback.addEventListener("click", async () => {
    smodalback.style.height = "0%";
    smodalback.style.transform = "translateY(-500px)";
    smodal.style.transform = "";
  });

  document.addEventListener("click", () => {
    selectSound.currentTime = 0;
    selectSound.volume = settings["sfx_volume"] / 100;
    selectSound.play();
  });

  const helpmodal = document.getElementsByClassName("helpmodal")[0];
  helpmodal.innerHTML = "test";
  document.getElementById("help").onclick = () => {
    helpmodal.style.zIndex = 99999;
    helpmodal.style.opacity = 1;
  }
  helpmodal.onclick = () => {
    helpmodal.style.zIndex = -810;
    helpmodal.style.opacity = 0;
  }
}
