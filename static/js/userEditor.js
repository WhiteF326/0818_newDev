import { fetchJSON } from './fetchP.js';

const isInRange = (val, l, r) => {
  return (l <= val && val < r);
}

class ChipInfo {
  // paths are str array
  #imgPaths = [];
  // low <= i < high
  #parameterLow = 0;
  #parameterHigh = 1;
  // fix parameter value to paths number
  #parameterExchange = prm => 0;
  // explain texts
  #explainTitle = "";
  #explainBody = "";
  // images
  #images = [];

  constructor(
    imgPaths,
    parameterLow, parameterHigh,
    parameterExchange,
    explainTitle, explainBody
  ) {
    this.#imgPaths = imgPaths;
    this.#parameterLow = parameterLow;
    this.#parameterHigh = parameterHigh;
    this.#parameterExchange = parameterExchange;
    this.#explainTitle = explainTitle;
    this.#explainBody = explainBody;

    this.#images = imgPaths.map(async r => {
      const img = await (new Promise(
        (res, rej) => {
          const ret = new Image();
          ret.src = "./img/" + r;
          ret.onload = () => res(ret);
          ret.onerror = e => rej(e);
        }
      ));
      return img;
    });
  }

  getImgPaths = () => this.#imgPaths;
  getParameterLow = () => this.#parameterLow;
  getParameterHigh = () => this.#parameterHigh;
  getParameterExchange = () => this.#parameterExchange;
  getExplainTitle = () => this.#explainTitle;
  getExplainBody = () => this.#explainBody;
  getImages = async () => this.#images;
}

class GameInfo {
  #chipInfoList = [];

  constructor(chipInfoList) {
    this.#chipInfoList = chipInfoList;
  }

  getChipInfo = (type) => this.#chipInfoList[type];
}

class MapInfo {
  #jsondata;

  // give a parsed info
  constructor(jsondata) {
    this.#jsondata = jsondata;
    console.log(jsondata)
  }

  // return map info object
  getMapObject = () => this.#jsondata;

  // edit map size
  addRow = () => {
    const columnWidth = this.#jsondata["stage"][0].length;
    this.#jsondata["stage"].push(Array(columnWidth).fill(0));
    this.#jsondata["param"].push(Array(columnWidth).fill(0));
  }
  removeRow = () => {
    if (this.#jsondata["stage"].length > 3) {
      this.#jsondata["stage"].pop();
      this.#jsondata["stage"].pop();
      this.#jsondata["stage"].push(
        new Array(this.#jsondata["stage"][0].length).fill(0)
      );
      this.#jsondata["param"].pop();
      this.#jsondata["param"].pop();
      this.#jsondata["param"].push(
        new Array(this.#jsondata["stage"][0].length).fill(0)
      );

      // キャラなどのはみ出し回避
      if (this.#jsondata["start"][0] >= this.#jsondata["stage"].length) {
        this.#jsondata["start"][0]--;
      }
      if (this.#jsondata["controll"][0] >= this.#jsondata["stage"].length) {
        this.#jsondata["controll"][0]--;
      }
      if (this.#jsondata["goal"][0] >= this.#jsondata["stage"].length) {
        this.#jsondata["goal"][0]--;
      }
    }
  }
  addColumn = () => {
    this.#jsondata["stage"].forEach(row => row.push(0));
    this.#jsondata["param"].forEach(row => row.push(0));
  }
  removeColumn = () => {
    if (this.#jsondata["stage"][0].length > 3) {
      this.#jsondata["stage"].forEach(row => row.pop());
      this.#jsondata["stage"].forEach(row => row.pop());
      this.#jsondata["stage"].forEach(row => row.push(0));
      
      this.#jsondata["param"].forEach(row => row.pop());
      this.#jsondata["param"].forEach(row => row.pop());
      this.#jsondata["param"].forEach(row => row.push(0));

      // キャラなどのはみ出し回避
      if (this.#jsondata["start"][1] >= this.#jsondata["stage"][0].length) {
        this.#jsondata["start"][1]--;
      }
      if (this.#jsondata["controll"][1] >= this.#jsondata["stage"][0].length) {
        this.#jsondata["controll"][1]--;
      }
      if (this.#jsondata["goal"][1] >= this.#jsondata["stage"][0].length) {
        this.#jsondata["goal"][1]--;
      }
    }
  }

  // edit map chip
  putChip = (x, y, type) => {
    if (this.#jsondata["stage"].length > y) {
      if (this.#jsondata["stage"][y].length > x) {
        this.#jsondata["stage"][y][x] = type;
      }
    }
  }
  putParam = (x, y, param) => {
    if (this.#jsondata["param"].length > y) {
      if (this.#jsondata["param"][y].length > x) {
        this.#jsondata["param"][y][x] = param;
      }
    }
  }

  // edit icon positions
  setCharaPosition = (x, y) => {
    // 行き先が床であるか、ゴールと重ならないか確認する
    if (this.#jsondata["stage"][y][x] === 1
      && (this.#jsondata["goal"][0] !== y || this.#jsondata["goal"][1] !== x)) {
      this.#jsondata["start"][0] = y;
      this.#jsondata["start"][1] = x;
    }
  }
  setCharaVector = (vector) => {
    this.#jsondata["start"][2] = vector;
  }
  setCursorPosition = (x, y) => {
    this.#jsondata["controll"][0] = y;
    this.#jsondata["controll"][1] = x;
  }
  setGoalPosition = (x, y) => {
    // キャラと重ならないか確認する
    if (this.#jsondata["stage"][y][x] === 1
      && this.#jsondata["start"][0] !== y || this.#jsondata["start"][1] !== x) {
      this.#jsondata["goal"][0] = y;
      this.#jsondata["goal"][1] = x;
    }
  }

  // cost, walk edit
  setCost = cost => {
    this.#jsondata["maxCost"] = cost;
  }
  setWalk = walk => {
    this.#jsondata["maxStep"] = walk;
  }

  // title, message edit
  setTitle = title => {
    this.#jsondata["title"] = title;
  }
  setMessage = message => {
    this.#jsondata["message"] = message;
  }

  // set unlock status
  setUnlockStatus = ary => {
    this.#jsondata["unlocked"] = ary;
  }

  // selection varidator
  selectionRange = () => {
    return [this.#jsondata["stage"][0].length, this.#jsondata["stage"].length];
  }

  // 選択マスをマップ内に修正したものを返す
  fixSelection = (x, y) => {
    return [
      Math.min(x, this.#jsondata["stage"][0].length - 1),
      Math.min(y, this.#jsondata["stage"].length - 1)
    ];
  }

  // verify stage
  verify = () => {
    let errors = "";
    // 不正なマップチップ
    if (
      this.#jsondata["stage"].map(r => {
        r.map(v => (v === 7 || v === 8) ? 1 : 0).reduce((a, b) => (a | b))
      }).reduce((a, b) => (a | b))
    ) {
      // マップ内に 7, 8 がある
      errors += "マップ内に押されたスイッチや開かれたドアがあります。<br>";
    }
    // 外周が木ではない
    console.log(
      this.#jsondata["stage"].map(r => {
        return r.map((v, i) => {
          if ((i === 0 || i === r.length - 1) && v !== 0) {
            return 1;
          } else {
            return 0;
          }
        })
      })
    )
    if (
      this.#jsondata["stage"][0].map(r => r !== 0).reduce((a, b) => (a | b))
      || this.#jsondata["stage"][
        this.#jsondata["stage"].length - 1
      ].map(r => r !== 0).reduce((a, b) => (a | b))
      || this.#jsondata["stage"].map(r => {
        return r.map((v, i) => {
          if ((i === 0 || i === r.length - 1) && v !== 0) {
            return 1;
          } else {
            return 0;
          }
        }).reduce((a, b) => (a | b))
      }).reduce((a, b) => a | b)
    ) {
      errors += "マップの最も上の行、下の行、左の列、右の列のいずれかに木でないマスがあります。<br>";
    }
    // パラメータ異常
    for (let y = 0; y < this.#jsondata["stage"].length; y++) {
      for (let x = 0; x < this.#jsondata["stage"][y].length; x++) {
        switch (this.#jsondata["stage"][y][x]) {
          case 0:
          case 1:
          case 2:
          case 3:
          case 9:
            if (this.#jsondata["param"][y][x] !== 0) {
              errors += "上から" + (y + 1) + "行目、左から" + (x + 1) + "列目のマスのパラメータが範囲外です。";
            }
            break;

          case 5:
          case 6:
            if (this.#jsondata["param"][y][x] < 0
              || this.#jsondata["param"][y][x] >= 5) {
              errors += "上から" + (y + 1) + "行目、左から" + (x + 1) + "列目のマスのパラメータが範囲外です。";
            }
            break;

          case 4:
            if (this.#jsondata["param"][y][x] < 0
              || this.#jsondata["param"][y][x] > 50) {
              errors += "上から" + (y + 1) + "行目、左から" + (x + 1) + "列目のマスのパラメータが範囲外です。";
            }
            break;
        }
      }
    }
    // キャラクターの開始位置
    if (this.#jsondata["start"][0] >= this.#jsondata["stage"][0].length
      || this.#jsondata["start"][1] >= this.#jsondata["stage"].length) {
      errors += "キャラクターの開始位置が不正です。<br>";
    } else {
      if (
        this.#jsondata["stage"]
        [this.#jsondata["start"][1]][this.#jsondata["start"][0]]
        !== 1
      ) {
        errors += "キャラクターの開始位置が床ではありません。<br>";
      }
    }
    // ゴールの位置
    if (this.#jsondata["goal"][1] >= this.#jsondata["stage"][0].length
      || this.#jsondata["goal"][0] >= this.#jsondata["stage"].length) {
      errors += "ゴールの開始位置が不正です。<br>";
    } else {
      if (
        this.#jsondata["stage"]
        [this.#jsondata["goal"][0]][this.#jsondata["goal"][1]]
        !== 1
      ) {
        errors += "ゴールの開始位置が床ではありません。<br>";
      }
    }
    // カーソルの位置
    if (this.#jsondata["controll"][1] >= this.#jsondata["stage"][0].length
      || this.#jsondata["controll"][0] >= this.#jsondata["stage"].length) {
      errors += "カーソルの開始位置が不正です。<br>";
    }
    // コストの範囲
    if (!isInRange(this.#jsondata["maxCost"], -1, 1001)) {
      errors += "残りコストが 0 未満であるか、1000 より大きく設定されています。<br>";
    }
    // 歩数の範囲
    if (!isInRange(this.#jsondata["maxStep"], -1, 1001)) {
      errors += "残り歩数が 0 未満であるか、1000 より大きく設定されています。<br>";
    }
    // タイトル
    if (!this.#jsondata["title"]) {
      errors += "タイトルが空です。入力して下さい。<br>";
    }
    // 開始メッセージ
    if (!this.#jsondata["message"]) {
      errors += "開始メッセージが空です。入力して下さい。<br>";
    }

    // エラーを返す
    return errors;
  }
}

class MapRenderer {
  #selectx;
  #selecty;
  #selectionImage;
  #tileSize;
  #charaImage;
  #cursorImage;
  #goalImage;

  // チップ情報の作成
  #chipInfoList = new Array(10).fill(null);

  // ゲーム全体情報のオブジェクト
  #gameInfo = null;

  constructor() {
    // 選択中のマス番号
    this.#selectx = 0;
    this.#selecty = 0;

    // 画像の定義
    this.#selectionImage = new Image();
    this.#selectionImage.src = "./img/cursor.png";

    this.#charaImage = new Image();
    this.#charaImage.src = "./img/charaAuto.png";

    this.#cursorImage = new Image();
    this.#cursorImage.src = "./img/charaHand.png";

    this.#goalImage = new Image();
    this.#goalImage.src = "./img/goal.png";

    // マップチップの定義
    this.#chipInfoList[0] = new ChipInfo(
      ["map01.png"], 0, 1, () => 0, "木", "キャラクターは通過できません。カーソルで破壊もできません。"
    );
    this.#chipInfoList[1] = new ChipInfo(
      ["map02.png"], 0, 1, () => 0, "床", "キャラクターも通過できます。カーソルで岩を置けます。"
    );
    this.#chipInfoList[2] = new ChipInfo(
      ["map03.png"], 0, 1, () => 0,
      "岩", "キャラクターは通過できません。カーソルは破壊できます。"
    );
    this.#chipInfoList[3] = new ChipInfo(
      ["spring.png"], 0, 1, () => 0,
      "バネ", "キャラクターが1マスジャンプします。"
    );
    this.#chipInfoList[4] = new ChipInfo(
      ["board0.png", "board1.png", "board2.png", "board3.png"],
      0, 51, prm => Math.min(prm, 3),
      "こわれる床", "キャラクターが通過すると耐久値が減ります。"
    );
    this.#chipInfoList[5] = new ChipInfo(
      ["switch1.png", "switch2.png", "switch3.png", "switch4.png", "switch5.png"],
      0, 5, prm => prm, "スイッチ", "ある色のスイッチがすべて押されると、同じ色のドアが開きます"
    );
    this.#chipInfoList[6] = new ChipInfo(
      ["door_off1.png", "door_off2.png", "door_off3.png", "door_off4.png", "door_off5.png"],
      0, 5, prm => prm, "ドア", "ある色のスイッチがすべて押されると、同じ色のドアが開きます"
    );
    this.#chipInfoList[7] = new ChipInfo(
      ["pushed1.png", "pushed2.png", "pushed3.png", "pushed4.png", "pushed5.png"],
      0, 5, prm => prm, "押されたスイッチ", "ある色のスイッチがすべて押されると、同じ色のドアが開きます"
    );
    this.#chipInfoList[8] = new ChipInfo(
      ["door_on1.png", "door_on2.png", "door_on3.png", "door_on4.png", "door_on5.png"],
      0, 5, prm => prm, "開かれたドア", "ある色のスイッチがすべて押されると、同じ色のドアが開きます"
    );
    this.#chipInfoList[9] = new ChipInfo(
      ["avoidCreate.png"], 0, 1, () => 0,
      "岩の配置禁止マス", "カーソルで岩を置くことはできません。"
    );
    this.#gameInfo = new GameInfo(this.#chipInfoList);
  }

  // 描画関数
  render = async (mapInfo, canvas) => {
    // タイルサイズの再計算
    this.#tileSize = Math.floor(
      Math.min(canvas.clientHeight, canvas.clientWidth)
      / Math.max(mapInfo["stage"].length, mapInfo["stage"][0].length)
    );
    // 描画開始
    const ctx = canvas.getContext("2d");
    ctx.fillRect(0, 0, canvas.clientHeight, canvas.clientWidth);
    for (let y = 0; y < mapInfo["stage"].length; y++) {
      for (let x = 0; x < mapInfo["stage"][y].length; x++) {
        const chipInfo = this.#gameInfo.getChipInfo(mapInfo["stage"][y][x]);
        const chipImage = await (await chipInfo.getImages())[
          chipInfo.getParameterExchange()(mapInfo["param"][y][x])
        ];
        ctx.drawImage(
          chipImage,
          0, 0, chipImage.width, chipImage.height,
          this.#tileSize * x, this.#tileSize * y, this.#tileSize, this.#tileSize
        );
      }
    }

    // カーソルを描画
    ctx.drawImage(
      this.#selectionImage,
      0, 0, this.#selectionImage.width, this.#selectionImage.height,
      this.#tileSize * this.#selectx, this.#tileSize * this.#selecty,
      this.#tileSize, this.#tileSize
    );
    // キャラを描画
    const ratio = 0.75;
    const vectorList = {
      "front": 0,
      "left": 1,
      "right": 2,
      "back": 3
    };
    ctx.drawImage(
      this.#charaImage,
      0, this.#charaImage.height * vectorList[mapInfo["start"][2]] / 4,
      this.#charaImage.width / 6, this.#charaImage.height / 4,
      this.#tileSize * mapInfo["start"][1] + this.#tileSize * (1 - ratio) / 2,
      this.#tileSize * mapInfo["start"][0],
      this.#tileSize * ratio, this.#tileSize
    );
    // カーソルを描画する
    ctx.drawImage(
      this.#cursorImage,
      0, 0, this.#cursorImage.width / 6, this.#cursorImage.height / 4,
      this.#tileSize * mapInfo["controll"][1]
      + this.#tileSize * (1 - ratio) / 2,
      this.#tileSize * mapInfo["controll"][0],
      this.#tileSize * ratio, this.#tileSize
    );
    // ゴールを描画する
    ctx.drawImage(
      this.#goalImage,
      0, 0, this.#goalImage.width, this.#goalImage.height,
      this.#tileSize * mapInfo["goal"][1]
      + this.#tileSize * (1 - ratio) / 2,
      this.#tileSize * mapInfo["goal"][0],
      this.#tileSize * ratio, this.#tileSize
    );

    // 選択マスの情報を表示する
    const selectInfo
      = this.#gameInfo.getChipInfo(
        mapInfo["stage"][this.#selecty][this.#selectx]
      );
    document.getElementById("selectedTitle").innerText
      = selectInfo.getExplainTitle()
      + " 縦" + String(this.#selecty + 1)
      + "行目、横" + String(this.#selectx + 1) + "列目";
    document.getElementById("selectedExplain").innerText
      = selectInfo.getExplainBody();
    document.getElementById("selectedParamRange").innerText
      = "パラメータのはんい：" + selectInfo.getParameterLow()
      + "～" + (selectInfo.getParameterHigh() - 1);
    document.getElementById("paramEditor").max
      = String(selectInfo.getParameterHigh() - 1);
    document.getElementById("paramEditor").value
      = mapInfo["param"][this.#selecty][this.#selectx];
  }

  // x, y を選択する
  select = (x, y, range) => {
    const tox = Math.floor(x / this.#tileSize);
    const toy = Math.floor(y / this.#tileSize);
    if (tox < range[0] && toy < range[1]) {
      this.#selectx = tox;
      this.#selecty = toy;
    }
  }
  
  // マス数単位の x, y を選択する
  selectByCell = (x, y) => {
    this.#selectx = x;
    this.#selecty = y;
  }

  // 実座標をマス数に治す
  exchangeToStep = (x, y) => {
    return [Math.floor(x / this.#tileSize), Math.floor(y / this.#tileSize)];
  }

  // 選択されている座標を返す
  getSelection = () => {
    return [this.#selectx, this.#selecty];
  }
}

class Palette {
  static #enabledChips = [0, 1, 2, 3, 4, 5, 6, 9, 10, 11];

  #selectedChipType;
  #selectedMode;
  #ctx;
  #paletteWidth;
  #icons;
  #choosenImage;

  constructor(canvas, icons, checkmark) {
    this.#selectedChipType = 0;
    this.#selectedMode = "select";
    this.#ctx = canvas.getContext("2d");
    this.#paletteWidth = canvas.clientWidth;
    this.#icons = icons;
    this.#choosenImage = checkmark;

    // パレットクリック時の処理
    canvas.onclick = e => {
      const clickX = e.pageX;

      const clientRect = canvas.getBoundingClientRect();
      const positionX = clientRect.left + window.scrollX;

      const x = clickX - positionX;

      const xsel = Math.floor(x / (this.#paletteWidth / 10));
      if (xsel < 8) {
        this.chooseChip(Palette.#enabledChips[xsel]);
      } else {
        if (xsel === 8) this.choosePaintMode();
        else this.chooseSelectMode();
      }

      this.render();
    }
  }

  choosePaintMode = () => {
    this.#selectedMode = "paint";
  }
  chooseSelectMode = () => {
    this.#selectedMode = "select";
  }

  chooseChip = type => {
    this.#selectedChipType = type;
  }

  getSelectedChipType = () => {
    return this.#selectedChipType;
  }
  getMode = () => {
    return this.#selectedMode;
  }

  render = () => {
    const cellSize = Math.min(32, this.#paletteWidth / 10);

    this.#ctx.fillStyle = "white";
    this.#ctx.fillRect(0, 0, this.#paletteWidth, 32);

    // 描画
    Palette.#enabledChips.forEach(async (v, i) => {
      const icon = await this.#icons[v];
      this.#ctx.drawImage(
        icon,
        0, 0,
        icon.naturalHeight, icon.naturalWidth,
        this.#paletteWidth * i / 10 + (this.#paletteWidth / 10 - cellSize) / 2,
        0,
        cellSize, cellSize
      );
      if (this.getSelectedChipType() === v) {
        this.#ctx.drawImage(
          this.#choosenImage,
          0, 0, 32, 32,
          this.#paletteWidth * i / 10
          + (this.#paletteWidth / 10 - cellSize) / 2,
          0,
          cellSize, cellSize
        );
      }
      if (
        {
          "paint": 10,
          "select": 11
        }[this.getMode()] === v
      ) {
        this.#ctx.drawImage(
          this.#choosenImage,
          0, 0, 32, 32,
          this.#paletteWidth * i / 10
          + (this.#paletteWidth / 10 - cellSize) / 2,
          0,
          cellSize, cellSize
        );
      }
    });
  }
}

class UnlockManager {
  #canvas;
  #unlockArray = [];
  #choosenImage;

  static #allBlocks = [
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
  ];
  static #allNames = [
    "進む",
    "足元の岩をこわす",
    "足元に岩を置く",
    "こわれるゆかを修復する + 1",
    "くりかえし実行",
    "条件分岐",
    "くりかえし〇回目～",
    "足元が岩である",
    "足元が木である",
    "足元がゆかである",
    "足元がこわれるゆかである"
  ];

  constructor(canvas, unlockArray, checkmark) {
    this.#canvas = canvas;
    this.#unlockArray = unlockArray;
    this.#choosenImage = checkmark;
  }

  toggle = typeNumber => {
    const type = UnlockManager.#allBlocks[typeNumber];
    if (UnlockManager.#allBlocks.findIndex(r => r === type) !== -1) {
      if (this.#unlockArray.findIndex(r => r === type) !== -1) {
        this.#unlockArray = this.#unlockArray.filter(r => r !== type);
      } else {
        this.#unlockArray.push(type);
      }
    }
  }

  render = () => {
    const ctx = this.#canvas.getContext("2d");
    ctx.clearRect(0, 0, this.#canvas.clientWidth, this.#canvas.clientHeight);
    ctx.font = "27px serif";
    for (let i = 0; i < 11; i++) {
      if (this.#unlockArray.find(r => r === UnlockManager.#allBlocks[i])) {
        ctx.drawImage(
          this.#choosenImage,
          0, 0, 32, 32,
          0, 27 * i, 27, 27
        );
      }
      ctx.fillText(
        UnlockManager.#allNames[i],
        27, 27 * (i + 1), 273
      );
    }
  }

  getUnlockList = () => {
    return this.#unlockArray;
  }
}

window.onload = async () => {
  // 未保存フラグ
  let unsaved = false;

  // ステージ id を url から取得
  const stageid = (new URL(window.location.href)).searchParams.get("stageid");

  // キャンバスサイズの調整
  document.getElementById("map").setAttribute("height",
    String(
      Math.round(
        (window.innerHeight - document.getElementById("head").clientHeight)
        / 2.2
      )
    )
  );
  document.getElementById("map").setAttribute(
    "width", String(Math.round(document.body.clientWidth / 2.2))
  );
  const canvas = document.getElementById("map");

  // マップ情報オブジェクト前処理
  const stagejson = JSON.parse(
    JSON.parse(await fetchJSON("api/create/search", {
      stageid: stageid,
      userid: localStorage.getItem("userid")
    }))
  );
  // 取得できていなかったらエラー表示をする

  // マップ情報オブジェクト
  const mapInfo = new MapInfo(stagejson);

  // マップ描画オブジェクト
  const mapRenderer = new MapRenderer();

  // マップサイズの変更ボタン
  document.getElementById("verticalDecrement").onclick = async () => {
    mapInfo.removeRow();
    mapRenderer.selectByCell(
      ...mapInfo.fixSelection(...mapRenderer.getSelection())
    );
    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }
  document.getElementById("verticalIncrement").onclick = async () => {
    mapInfo.addRow();
    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }
  document.getElementById("horizontalDecrement").onclick = async () => {
    mapInfo.removeColumn();
    mapRenderer.selectByCell(
      ...mapInfo.fixSelection(...mapRenderer.getSelection())
    );
    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }
  document.getElementById("horizontalIncrement").onclick = async () => {
    mapInfo.addColumn();
    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }

  // チェックマーク
  const checkmark = await new Promise(
    (res, rej) => {
      const ret = new Image();
      ret.src = "./img/choosen.png";
      ret.onload = () => res(ret);
      ret.onerror = e => rej(e);
    }
  );

  // パレット
  document.getElementById("palette").width
    = document.getElementById("map").width;
  document.getElementById("palette").height = "32";
  const iconNames = [
    "map01.png", "map02.png", "map03.png", "spring.png", "board0.png",
    "switch1.png", "door_off1.png", "pushed1.png", "door_on1.png",
    "avoidCreate.png", "brush.png", "choose.png"
  ];
  const icons = iconNames.map(async r => {
    // const ret = new Image();
    // ret.src = "./img/" + r;
    // return ret;
    const ret = await new Promise(
      (res, rej) => {
        const img = new Image();
        img.src = "./img/" + r;
        img.onload = () => res(img);
        img.onerror = e => rej(e);
      }
    );
    return ret;
  });
  const palette = new Palette(
    document.getElementById("palette"), icons, checkmark
  );
  palette.render();

  // 選択モード時の、マップ上でのクリックイベント
  document.getElementById("map").onclick = async e => {
    if (palette.getMode() === "select") {
      const clickX = e.pageX;
      const clickY = e.pageY;

      const clientRect = document.getElementById("map").getBoundingClientRect();
      const positionX = clientRect.left + window.scrollX;
      const positionY = clientRect.top + window.scrollY;

      const x = clickX - positionX;
      const y = clickY - positionY;

      mapRenderer.select(x, y, mapInfo.selectionRange());

      await mapRenderer.render(mapInfo.getMapObject(), canvas);
    }
  }

  // ペイントモード時のマップ上でのクリックイベント
  let painting = false;
  const paintOut = async e => {
    if (palette.getMode() === "paint") {
      const clickX = e.pageX;
      const clickY = e.pageY;

      const clientRect
        = document.getElementById("map").getBoundingClientRect();
      const positionX = clientRect.left + window.scrollX;
      const positionY = clientRect.top + window.scrollY;

      const x = clickX - positionX;
      const y = clickY - positionY;

      const points = mapRenderer.exchangeToStep(x, y);
      mapInfo.putChip(points[0], points[1], palette.getSelectedChipType());

      await mapRenderer.render(mapInfo.getMapObject(), canvas);
      unsaved = true;
    }
  }
  document.getElementById("map").onmousedown = async e => {
    await paintOut(e);
    painting = true;
  }
  document.getElementById("map").onmousemove = async e => {
    if (painting) await paintOut(e);
  }
  document.getElementById("map").onmouseup = async e => {
    await paintOut(e);
    painting = false;
  }
  document.getElementById("map").onmouseleave = () => {
    painting = false;
  }

  // 右クリックの禁止
  document.getElementById("map").oncontextmenu = e => {
    e.preventDefault();
  }

  // paramEditor の変動イベント
  document.getElementById("paramEditor").onchange = async () => {
    mapInfo.putParam(
      ...mapRenderer.getSelection(),
      Number(document.getElementById("paramEditor").value)
    );

    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }

  // キャラ配置ボタン
  document.getElementById("putChara").onclick = async () => {
    mapInfo.setCharaPosition(...mapRenderer.getSelection());
    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }
  document.getElementById("putCursor").onclick = async () => {
    mapInfo.setCursorPosition(...mapRenderer.getSelection());
    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }
  document.getElementById("putGoal").onclick = async () => {
    mapInfo.setGoalPosition(...mapRenderer.getSelection());
    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }

  // キャラ向き変更
  document.getElementById("charaVector").onchange = async () => {
    mapInfo.setCharaVector(document.getElementById("charaVector").value);
    await mapRenderer.render(mapInfo.getMapObject(), canvas);
    unsaved = true;
  }

  document.getElementById("charaVector").value
    = mapInfo.getMapObject()["start"][2];

  // コストと歩数の設定
  document.getElementById("cost").value
    = mapInfo.getMapObject()["maxCost"];
  document.getElementById("cost").onchange = () => {
    mapInfo.setCost(Number(document.getElementById("cost").value));
    unsaved = true;
  }
  document.getElementById("step").value
    = mapInfo.getMapObject()["maxStep"];
  document.getElementById("step").onchange = () => {
    mapInfo.setWalk(Number(document.getElementById("step").value));
    unsaved = true;
  }

  // タイトル、開始メッセージの設定
  document.getElementById("title").value
    = mapInfo.getMapObject()["title"];
  document.getElementById("title").onchange = () => {
    mapInfo.setTitle(document.getElementById("title").value);
    unsaved = true;
  }
  document.getElementById("message").innerText
    = mapInfo.getMapObject()["message"];
  document.getElementById("message").onchange = () => {
    mapInfo.setMessage(document.getElementById("message").value);
    unsaved = true;
  }

  // ブロック解放状態の管理
  const unlockManager = new UnlockManager(
    document.getElementById("unlocker"),
    mapInfo.getMapObject()["unlocked"],
    checkmark
  );
  document.getElementById("unlocker").onclick = e => {
    const clickY = e.pageY;

    const clientRect
      = document.getElementById("unlocker").getBoundingClientRect();
    const positionY = clientRect.top + window.scrollY;

    const y = clickY - positionY;

    const ysel = Math.floor(
      y / (document.getElementById("unlocker").clientHeight / 11)
    );

    unlockManager.toggle(ysel);

    mapInfo.setUnlockStatus(unlockManager.getUnlockList());

    unlockManager.render();
    unsaved = true;
  }
  unlockManager.render();

  // 保存機能の実装
  document.getElementById("save").onclick = async () => {
    const errors = mapInfo.verify();
    const modal = document.getElementsByClassName("modalback")[0];
    const modalbody = document.getElementById("modalbody");
    Array.from(document.getElementById("modalbody").childNodes)
      .forEach(r => {
        r.remove();
      }
      );

    if (errors) {
      modalbody.innerHTML += errors;
    } else {
      modalbody.innerHTML += "保存されました。";
      await fetchJSON("api/create/update", {
        userid: localStorage.getItem("userid"),
        stageid: stageid,
        stagetext: JSON.stringify(mapInfo.getMapObject())
      });
      unsaved = false;
    }

    modalbody.appendChild(document.createElement("br"));
    const ok = document.createElement("button");
    ok.innerText = "はい";
    ok.onclick = async () => {
      modal.style.transform = "translateY(-500px)";
      modal.style.height = "0%";
    }
    modalbody.appendChild(ok);

    modal.style.transition = "1s";
    modal.style.transform = "translateY(0)";
    modal.style.height = "100%";
    modal.style.width = document.body.clientWidth + "px";
  }

  // テストプレイの実装
  document.getElementById("test").onclick = () => {
    // TODO 未保存のときに確認する
    if (unsaved) {
      Array.from(document.getElementById("modalbody").childNodes)
        .forEach(r => {
          r.remove();
        }
        );
      const modal = document.getElementsByClassName("modalback")[0];
      const modalbody = document.getElementById("modalbody");
      modalbody.appendChild(document.createTextNode(
        "このマップは変更されています。テストを開始する前に、変更を保存してください。"
      ));
      modalbody.appendChild(document.createElement("br"));
      const ok = document.createElement("button");
      ok.innerText = "はい";
      ok.onclick = async () => {
        modal.style.transform = "translateY(-500px)";
        modal.style.height = "0%";
      }
      modalbody.appendChild(ok);

      modal.style.transition = "1s";
      modal.style.transform = "translateY(0)";
      modal.style.height = "100%";
      modal.style.width = document.body.clientWidth + "px";
    } else {
      localStorage.setItem("gameEnabled", "testplay");
      localStorage.setItem("testplayId", stageid);
      window.location.href = "testPlayer.html";
    }

  }

  // 公開処理の実装
  document.getElementById("publish").onclick = async () => {
    const isPublishable = JSON.parse(
      await fetchJSON("api/create/cleared", {
        "userid": localStorage.getItem("userid"),
        "stagetext": JSON.stringify(mapInfo.getMapObject())
      })
    );
    Array.from(document.getElementById("modalbody").childNodes)
      .forEach(r => {
        r.remove();
      }
      );

    const modal = document.getElementsByClassName("modalback")[0];
    const modalbody = document.getElementById("modalbody");

    if (isPublishable) {
      modalbody.appendChild(document.createTextNode(
        "このマップはテストクリアされています。公開しますか？"
      ));
      modalbody.appendChild(document.createElement("br"));
      const ok = document.createElement("button");
      ok.innerText = "はい";
      ok.onclick = async () => {
        modal.style.transform = "translateY(-500px)";
        modal.style.height = "0%";
        await fetchJSON("api/create/publish", {
          "userid": localStorage.getItem("userid"),
          "stageid": stageid
        });
      }
      modalbody.appendChild(ok);
      const no = document.createElement("button");
      no.innerText = "いいえ";
      no.onclick = () => {
        modal.style.transform = "translateY(-500px)";
        modal.style.height = "0%";
      }
      modalbody.appendChild(no);
    } else {
      modalbody.appendChild(document.createTextNode(
        "まだこの設定でこのマップをテストクリアしていません。"
      ));
      modalbody.appendChild(document.createElement("br"));
      const ok = document.createElement("button");
      ok.innerText = "閉じる";
      ok.onclick = () => {
        modal.style.transform = "translateY(-500px)";
        modal.style.height = "0%";
      }
      modalbody.appendChild(ok);
    }

    modal.style.transition = "1s";
    modal.style.transform = "translateY(0)";
    modal.style.height = "100%";
    modal.style.width = document.body.clientWidth + "px";
  }

  await mapRenderer.render(mapInfo.getMapObject(), canvas);
}
