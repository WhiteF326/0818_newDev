class UserProgBody {
  constructor() {
    this.blocks = {
      0: {
        name: "empty",
        cost: 0
      },
      1: {
        name: "start",
        cost: 0
      },
      2: {
        name: "move",
        cost: 1
      },
      3: {
        name: "destroy",
        cost: 2
      },
      4: {
        name: "create",
        cost: 2
      },
      5: {
        name: "loop",
        cost: 1
      },
      6: {
        name: "next",
        cost: 0
      },
      7: {
        name: "if",
        cost: 2
      }
    };
    this.params = {
      3: {
        "vector": [
          "right",
          "left",
          "up",
          "down"
        ]
      },
      5: {
        "counter": 0
      },
    }
    this.sensors = [
      "front",
      "foot",
      "destroyable"
    ]
  }
  pInit = (y, x) => {
    this.y = y;
    this.x = x;

    const progBoad = document.getElementById("program");
    this.ctx = progBoad.getContext("2d");

    this.tileSize = Math.min(
      Math.floor(
        Math.floor(document.body.clientWidth / 2.2) / Math.max(x, y)),
      64
    );

    this.drawY = y * this.tileSize;
    this.drawX = x * this.tileSize;

    progBoad.setAttribute(
      "width", this.drawX
    );
    progBoad.setAttribute(
      "height", this.drawY
    );

    this.ctx.beginPath();
    this.ctx.font = "48px Arial";

    this.stage = new Array(y);
    for (let i = 0; i < y; i++) {
      const col = new Array(x);
      col.fill({type: 0, param: {}});
      this.stage[i] = col;
    }
    this.stage[0][0] = {type: 1, param: {}};
  }
  
  getProgram = (y, x) => {
    return this.stage[y][x];
  }
  getProgramName = (typeNumber) => {
    return this.blocks[typeNumber];
  }

  renderProgram = () => {
    // 初期化
    this.ctx.clearRect(0, 0, this.drawX, this.drawY);

    // 横線
    for (let i = 1; i <= this.y; i++) {
      this.ctx.moveTo(0, i * this.tileSize);
      this.ctx.lineTo(this.drawX, i * this.tileSize);
    }
    // 縦線
    for (let i = 1; i <= this.x; i++) {
      this.ctx.moveTo(i * this.tileSize, 0);
      this.ctx.lineTo(i * this.tileSize, this.drawY);
    }
    // 線全体の描画
    this.ctx.strokeStyle = "black";
    this.ctx.lineWidth = 1;
    this.ctx.stroke();

    // プログラムの描画
    let currentCost = 0;
    for(let h = 0; h < this.y; h++){
      for(let w = 0; w < this.x; w++){
        const prog = this.stage[h][w];
        currentCost += this.blocks[prog["type"]]["cost"];
        this.ctx.fillText(
          this.blocks[prog["type"]]["name"].split("")[0],
          w * this.tileSize, (h + 1) * this.tileSize,
          this.tileSize
        )
      }
    }
    this.ctx.stroke();

    return currentCost;
  }
}