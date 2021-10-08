class EditorBody {
  constructor(problem) {
    this.previewStage = document.getElementById("previewStage");
    this.prevCtx = previewStage.getContext("2d");
    this.problem = problem;

    this.modified = false;
    this.previewSize = 400;

    this.tileSize = 40;

    this.previewStage.width = this.previewSize;
    this.previewStage.height = this.previewSize;

    this.chipList = new ChipList();

    this.charaAuto = new CharaAuto(problem["start"][2], this.tileSize);
    this.maptileGoal = new Chip('./img/goal.png');
    this.charaHand = new CharaHand("right");

    this.selected = [0, 0];

    this.#render();

    // キー操作実装
    document.body.addEventListener("keypress", e => {
      if (e.key === "W") {
        this.#changeMapSize(0, -1);
      }
      if (e.key === "A") {
        this.#changeMapSize(-1, 0);
      }
      if (e.key === "S") {
        this.#changeMapSize(0, 1);
      }
      if (e.key === "D") {
        this.#changeMapSize(1, 0);
      }
      if (e.key === "g") {
        this.problem["goal"][0] = this.selected[1];
        this.problem["goal"][1] = this.selected[0];
      }
      if (e.key === "c") {
        this.problem["controll"][0] = this.selected[1];
        this.problem["controll"][1] = this.selected[0];
      }
      if (e.key === "p") {
        this.problem["start"][0] = this.selected[1];
        this.problem["start"][1] = this.selected[0];
      }
      if (e.key === "t") {
        this.problem["start"][2] = {
          "left": "front",
          "front": "right",
          "right": "back",
          "back": "left"
        }[this.problem["start"][2]];
        this.charaAuto.setVector(this.problem["start"][2]);
      }
      if (e.key === "+") {
        this.problem["param"][this.selected[1]][this.selected[0]]++;
      }
      if (e.key === "-") {
        this.problem["param"][this.selected[1]][this.selected[0]]--;
      }
      if (e.key.match("[0-9]")) {
        if (!(document.activeElement.tagName !== "BODY")) {
          this.problem["stage"][this.selected[1]][this.selected[0]]
            = Number(e.key);
        }
      }
    });

    this.previewStage.addEventListener("click", e => {
      const rangeX = this.problem["stage"][0].length;
      const rangeY = this.problem["stage"].length;

      const clickX = e.pageX;
      const clickY = e.pageY;

      const clientRect = this.previewStage.getBoundingClientRect();
      const positionX = clientRect.left + window.scrollX
      const positionY = clientRect.top + window.scrollY;

      const x = clickX - positionX;
      const y = clickY - positionY;

      this.selected[0] = Math.min(Math.floor(x / this.tileSize), rangeX - 1);
      this.selected[1] = Math.min(Math.floor(y / this.tileSize), rangeY - 1);
    });

    // コスト一覧を作成
    const costList = document.getElementById("costList");
    Object.keys(defaultCost).forEach(blockId => {
      const r = document.createElement("tr");

      const blockName = progListText[blockId];
      const nameCell = document.createElement("td");
      nameCell.appendChild(document.createTextNode(blockName));
      r.appendChild(nameCell);

      const blockCost = this.problem["costList"][blockId];
      const costCell = document.createElement("td");
      const costEdit = document.createElement("input");
      costEdit.type = "number";
      costEdit.value = blockCost || defaultCost[blockId];
      costEdit.name = "cost_" + blockId;
      costCell.appendChild(costEdit);
      r.appendChild(costCell);

      costList.appendChild(r);
    });

    // コスト制限、歩数制限
    const costR = document.createElement("tr");
    const costD = document.createElement("td");
    costD.appendChild(document.createTextNode("総コスト"));
    const maxCostCell = document.createElement("td");
    const maxCostEdit = document.createElement("input");
    maxCostEdit.type = "number";
    maxCostEdit.value = this.problem["maxCost"];
    maxCostEdit.name = "maxCost";
    maxCostCell.appendChild(maxCostEdit);
    costR.appendChild(costD);
    costR.appendChild(maxCostCell);
    costList.appendChild(costR);

    const walkR = document.createElement("tr");
    const walkD = document.createElement("td");
    walkD.appendChild(document.createTextNode("最大歩数"));
    const maxWalkCell = document.createElement("td");
    const maxWalkEdit = document.createElement("input");
    maxWalkEdit.type = "number";
    maxWalkEdit.value = this.problem["maxStep"];
    maxWalkEdit.name = "maxStep";
    maxWalkCell.appendChild(maxWalkEdit);
    walkR.appendChild(walkD);
    walkR.appendChild(maxWalkCell);
    costList.appendChild(walkR);

    // ブロック一覧を作成
    const blockList = document.getElementById("blockList");
    allBlocks.forEach(blockId => {
      const r = document.createElement("tr");

      const blockName = progListText[blockId];
      const nameCell = document.createElement("td");
      nameCell.appendChild(document.createTextNode(blockName));
      r.appendChild(nameCell);

      const blockCheck = this.problem["unlocked"].find(
        elm => elm === blockId
      ) ? true : false;
      const checkCell = document.createElement("td");
      const checkEdit = document.createElement("input");
      checkEdit.type = "checkbox"
      checkEdit.checked = blockCheck;
      checkEdit.name = "check_" + blockId;
      checkCell.appendChild(checkEdit);
      r.appendChild(checkCell);

      blockList.appendChild(r);
    });

    // 開始メッセージ
    document.getElementById("startMessage").value
      = this.problem["message"];
  }

  #render() {
    // 背景描画
    this.prevCtx.fillStyle = "black";
    this.prevCtx.fillRect(0, 0, this.previewSize, this.previewSize);

    this.prevCtx.font = "24px serif";
    this.prevCtx.fillStyle = "#FFD700";

    // チップ描画
    const x = this.problem["stage"][0].length;
    const y = this.problem["stage"].length;

    for (let i = 0; i < y; i++) {
      for (let j = 0; j < x; j++) {
        // 画像描画
        const chip = this.chipList.getChip(
          this.problem["stage"][i][j], this.problem["param"][i][j]
        );
        this.prevCtx.drawImage(
          chip,
          0, 0,
          chip.naturalHeight, chip.naturalWidth,
          this.tileSize * j, this.tileSize * i,
          this.tileSize, this.tileSize,
        );

        // パラメータ描画
        const param = this.chipList.printParam[this.problem["stage"][i][j]](
          this.problem["param"][i][j]
        );
        this.prevCtx.fillText(
          param,
          j * this.tileSize, i * this.tileSize + 20
        );
      }
    }

    // キャラ描画
    this.charaAuto.setPos(
      this.problem["start"][0] * this.tileSize,
      this.problem["start"][1] * this.tileSize
      + this.charaAuto.getOffset(this.tileSize),
    );

    const assetA = this.charaAuto.getAsset(1);
    // console.log(asset['image']);
    const sizeA = this.charaAuto.sizeExchange(this.tileSize);
    this.prevCtx.drawImage(
      assetA['image'],
      assetA["positionX"], assetA["positionY"],
      this.charaAuto.getcharaX(), this.charaAuto.getcharaY(),
      this.charaAuto.getposX(), this.charaAuto.getposY(),
      sizeA['x'], sizeA['y']
    );

    // カーソル描画
    this.charaHand.setPos(
      this.problem["controll"][0] * this.tileSize,
      this.problem["controll"][1] * this.tileSize
      + this.charaAuto.getOffset(this.tileSize),
    );

    const assetH = this.charaHand.getAsset(1);
    // console.log(asset['image']);
    const sizeH = this.charaHand.sizeExchange(this.tileSize);
    this.prevCtx.drawImage(
      assetH['image'],
      assetH["positionX"], assetH["positionY"],
      this.charaHand.getcharaX(), this.charaHand.getcharaY(),
      this.charaHand.getposX(), this.charaHand.getposY(),
      sizeH['x'], sizeH['y']
    );

    // ゴール描画
    this.prevCtx.drawImage(
      this.maptileGoal,
      0, 0,
      this.maptileGoal.naturalHeight, this.maptileGoal.naturalWidth,
      this.problem["goal"][1] * this.tileSize,
      this.problem["goal"][0] * this.tileSize,
      this.tileSize, this.tileSize
    );

    // 選択ブロックの表示
    document.getElementById("selected").innerText =
      "選択しているブロック：" + this.selected[0] + "," + this.selected[1]

    requestAnimationFrame(this.#render.bind(this));
  }

  #changeMapSize(cx, cy) {
    const x = this.problem["stage"][0].length;
    const y = this.problem["stage"].length;
    let dy = y + cy;
    let dx = x + cx;

    if (dy >= 3) {
      // 変更
      if (cy < 0) {
        for (let i = 0; i < Math.abs(cy); i++) {
          this.problem["stage"].pop();
          this.problem["param"].pop();
        }
      } else {
        for (let i = 0; i < cy; i++) {
          this.problem["stage"].push(
            new Array(x).fill(0).map(() => 0)
          );
          this.problem["param"].push(
            new Array(x).fill(0).map(() => 0)
          );
        }
      }
    }
    if (dx >= 3) {
      // 変更
      if (cx < 0) {
        for (let i = 0; i < Math.abs(cx); i++) {
          this.problem["stage"].forEach(line => line.pop());
          this.problem["param"].forEach(line => line.pop());
        }
      } else {
        for (let i = 0; i < cx; i++) {
          this.problem["stage"].forEach(line => line.push(0));
          this.problem["param"].forEach(line => line.push(0));
        }
      }
    }
  }

  exportProblem = () => {
    // コスト一覧、ブロック一覧の評価
    document.getElementById("costList").childNodes.forEach(n => {
      const ctr = n.lastChild.firstChild;
      if(ctr.name.includes("_")){
        this.problem["costList"][ctr.name.split("_")[1]] = ctr.value;
      }
    });

    this.problem["unlocked"] = [];
    document.getElementById("blockList").childNodes.forEach(n => {
      const ctr = n.lastChild.firstChild;
      if(ctr.checked){
        this.problem["unlocked"].push(ctr.name.split("_")[1]);
      }
    });

    // コストと歩数の評価
    this.problem["maxCost"]
      = document.getElementsByName("maxCost")[0].value;
    this.problem["maxStep"]
      = document.getElementsByName("maxStep")[0].value;
    
    // 開始メッセージの評価
    this.problem["message"]
      = document.getElementById("startMessage").value;

    return this.problem;
  }
}