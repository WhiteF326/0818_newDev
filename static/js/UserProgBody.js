class UserProgBody {
  constructor() {
    this.blocks = {
      0: {
        name: "empty",
        cost: 0
      },
      1: {
        name: "move",
        cost: 1
      },
      2: {
        name: "destroy",
        cost: 2
      },
      3: {
        name: "create",
        cost: 2
      },
      4: {
        name: "loop",
        cost: 1
      },
      5: {
        name: "next",
        cost: 0
      },
      6: {
        name: "if",
        cost: 2
      },
      7: {
        name: "start",
        cost: 0
      },
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
    ];
    this.background = new Image();
    this.background.setAttribute("src", "img/progBack.jpg");
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
    this.ctx.font = "48px Times New Roman";
    this.ctx.fillStyle = "white";

    this.stage = new Array(y);
    for (let i = 0; i < y; i++) {
      const col = new Array(x);
      for(let j = 0; j < x; j++){
        col[j] = {type: 0, param: {}}
      }
      this.stage[i] = col;
    }
    this.stage[0][0] = {type: 7, param: {}};

    progBoad.addEventListener("click", e => {
      e.preventDefault();
      const rect = e.target.getBoundingClientRect();

      const vx = e.clientX - rect.left;
      const vy = e.clientY - rect.top;

      const sx = progBoad.clientWidth / progBoad.width;
      const sy = progBoad.clientHeight / progBoad.height;

      const px = Math.floor(Math.floor(vx / sx) / this.tileSize);
      const py = Math.floor(Math.floor(vy / sy) / this.tileSize);

      if(px || py){
        this.stage[py][px]["type"] += 1;
        this.stage[py][px]["type"] %= 7;
      }

      console.log(this.stage.map(x => x.map(y => y["type"])));

      // プログラム板の描画
      const currentCost = this.renderProgram();
      document.getElementById("cost").innerText = 
        "現在コスト：" + currentCost + "\n";
    });

    // 最初の描画
    const currentCost = this.renderProgram();
    document.getElementById("cost").innerText = 
      "現在コスト：" + currentCost + "\n";
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

    // 背景の描画
    this.ctx.drawImage(
      this.background,
      0, 0,
      this.background.width, this.background.height,
      0, 0,
      this.drawX, this.drawY
    );

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
        if(prog["type"]){
          currentCost += this.blocks[prog["type"]]["cost"];
          this.ctx.fillText(
            this.blocks[prog["type"]]["name"].split("")[0],
            (w + 0.25) * this.tileSize, (h + 0.75) * this.tileSize,
            this.tileSize
          );
        }
      }
    }

    return currentCost;
  }
}