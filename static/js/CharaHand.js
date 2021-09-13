class CharaHand {
  constructor(vector) {
    this.charaX = 32;
    this.charaY = 48;
    this.posX = 0;
    this.posY = 0;

    this.pendingMove = [];

    this.originalImg = new Image();
    this.originalImg.setAttribute("src", "./img/charaHand.png");

    this.vector = vector;

    this.sign = (v) => {
      return (v > 0) - (v < 0);
    }
  }

  getAsset(frame) {
    if (frame === 3) frame = 1;
    return {
      "image": this.originalImg,
      "positionY": {
        "front": 0,
        "left": 1,
        "right": 2,
        "back": 3
      }[this.vector] * this.charaY,
      "positionX": this.charaX * frame
    };
  }

  setVector(vector) {
    this.vector = vector;
  }

  setPos(y, x) {
    this.posX = x;
    this.posY = y;
  }

  addMove(y, x) {
    this.pendingMove.push([y, x]);
  }
  addCursorAction(type){
    this.pendingMove.push(type);
  }
  moveFrame(speed) {
    if (this.pendingMove.length != 0) {
      if(typeof this.pendingMove[0] === "string"){
        const action = this.pendingMove[0];
        this.pendingMove.shift();
        if(action === "destroy"){
          return "destroy";
        }else if(action === "create"){
          return "create";
        }
      } else {
        const xway = this.sign(this.pendingMove[0][1]);
        const yway = this.sign(this.pendingMove[0][0]);
        const xmove = Math.min(Math.abs(this.pendingMove[0][1]), speed) * xway;
        const ymove = Math.min(Math.abs(this.pendingMove[0][0]), speed) * yway;

        this.posX += xmove;
        this.posY += ymove;
        this.pendingMove[0][1] -= xmove;
        this.pendingMove[0][0] -= ymove;

        if (
          Math.abs(this.pendingMove[0][1]) == 0
          && Math.abs(this.pendingMove[0][0] == 0)) {
          this.pendingMove.shift();
          return [xway, yway];
        }

        return false;
      }
    }
  }

  getposX = () => this.posX;
  getposY = () => this.posY;
  getcharaX = () => this.charaX;
  getcharaY = () => this.charaY;

  sizeExchange(size) {
    return {
      "y": size,
      "x": Math.floor(size * 3 / 4)
    };
  }
  getOffset = (size) => Math.ceil(size / 8);

  isWaitFor = () => !this.pendingMove.length;
}