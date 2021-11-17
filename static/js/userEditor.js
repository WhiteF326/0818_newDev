import { fetchJSON } from './fetchP.js';

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
  }

  // return map info object
  getMapObject = () => this.#jsondata;

  // edit map size
  addRow = () => {
    const columnWidth = this.#jsondata[0].length;
    this.#jsondata["stage"].append(Array(columnWidth).fill(0));
    this.#jsondata["param"].append(Array(columnWidth).fill(0));
  }
  removeRow = () => {
    if (this.#jsondata["stage"].length > 3) {
      this.#jsondata["stage"].pop();
      this.#jsondata["param"].pop();
    }
  }
  addColumn = () => {
    this.#jsondata["stage"].forEach(row => row.push(0));
    this.#jsondata["param"].forEach(row => row.push(0));
  }
  removeColumn = () => {
    if (this.#jsondata["stage"][0].length > 3) {
      this.#jsondata["stage"].forEach(row => row.pop());
      this.#jsondata["param"].forEach(row => row.pop());
    }
  }

  // edit map chip
  putChip = (x, y, type) => {
    this.#jsondata["stage"][x][y] = type;
  }
  putParam = (x, y, param) => {
    this.#jsondata["param"][x][y] = param;
  }
}

class MapRenderer {
  #selectx;
  #selecty;

  // チップ情報の作成
  #chipInfoList = new Array(10).fill(null);

  // ゲーム全体情報のオブジェクト
  #gameInfo = null;

  constructor() {
    this.#selectx = 0;
    this.#selecty = 0;

    this.#chipInfoList[0] = new ChipInfo(
      ["map01.png"], 0, 1, () => 0, "木", "キャラクターは通過できません。"
    );
    this.#chipInfoList[1] = new ChipInfo(
      ["map02.png"], 0, 1, () => 0, "床", "キャラクターも通過できます。"
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
      0, 51, prm => Math.max(prm, 3),
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
      "岩の配置禁止マス", "キャラクターは通過できます。カーソルはこのマスに岩を置けません"
    );
    this.#gameInfo = new GameInfo(this.#chipInfoList);
  }

  render = async (mapInfo, canvas = new HTMLCanvasElement()) => {
    const tileSize = Math.floor(
      Math.min(canvas.clientHeight, canvas.clientWidth)
      / Math.max(mapInfo["stage"].length, mapInfo["stage"][0].length)
    );
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
          tileSize * x, tileSize * y, tileSize, tileSize
        );
      }
    }
  }

  select = (x, y) => {
    this.#selectx = x;
    this.#selecty = y;
  }
}

window.onload = async () => {
  // ステージ id を url から取得
  const stageid = (new URL(window.location.href)).searchParams.get("stageid");

  // キャンバスサイズの調整
  document.getElementById("map").setAttribute("height", String(
    Math.round(
      window.innerHeight - document.getElementById("head").clientHeight) / 2.2
  )
  )
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

  await mapRenderer.render(mapInfo.getMapObject(), canvas);
}
