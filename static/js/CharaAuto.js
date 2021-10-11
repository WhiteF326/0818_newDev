class CharaAuto {
  constructor(vector, tileSize, settings) {
    this.charaX = 32;
    this.charaY = 48;
    this.posX = 0;
    this.posY = 0;

    this.pendingMove = [];

    this.originalImg = new Image();
    this.originalImg.setAttribute("src", "./img/charaAuto.png");

    this.vector = vector;

    this.sign = (v) => {
      return (v > 0) - (v < 0);
    }

    this.velocity = 0;
    this.isJunping = false;
    this.difference = 0;
    this.jumpTime = 0;
    this.isChained = false;

    this.tileSize = tileSize;

    this.settings = settings;
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
      "positionX": this.charaX * frame,
    };
  }

  setVector(vector) {
    this.vector = vector;
  }

  setPos(y, x) {
    this.posX = x;
    this.posY = y;
  }

  addMove(y, x, isJunp) {
    footstepsSound.volume
      0.5 * this.settings["sfx_volume"] / 100;
    footstepsSound.play();
    this.pendingMove.push([y, x, (isJunp ? 2 : 0)]);
  }
  moveFrame(speed) {
    this.updateJump(speed);
    if (this.pendingMove.length != 0) {
      const xway = this.sign(this.pendingMove[0][1]);
      const yway = this.sign(this.pendingMove[0][0]);
      const isJunp = this.pendingMove[0][2];
      if (isJunp == 2) {
        this.setJump(speed);
        this.pendingMove[0][2] = 1;
      }
      const xmove = Math.min(
        Math.abs(this.pendingMove[0][1]), speed * (isJunp ? 2 : 1)
      ) * xway;
      const ymove = Math.min(
        Math.abs(this.pendingMove[0][0]), speed * (isJunp ? 2 : 1)
      ) * yway;

      this.posX += xmove;
      this.posY += ymove;
      this.pendingMove[0][1] -= xmove;
      this.pendingMove[0][0] -= ymove;

      if (
        Math.abs(this.pendingMove[0][1]) == 0
        && Math.abs(this.pendingMove[0][0] == 0)) {
        this.pendingMove.shift();
        return 1;
      } else {
        return 0;
      }
    }
  }

  getposX = () => this.posX;
  getposY = () => {
    return this.posY - this.difference;
  };
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

  #degToRad = (deg) => deg * Math.PI / 180;

  setJump = (charaSpeed) => {
    this.velocity = -32;
    this.isJunping = true;
    this.difference = 0;
    this.jumpTime = -(this.tileSize / charaSpeed / 2);
  }
  updateJump = (charaSpeed) => {
    if (this.isJunping) {
      this.jumpTime++;
      if(!Math.floor(this.jumpTime)){
        jumpSound.currentTime = 0;
        jumpSound.volume = 0.5  * this.settings["sfx_volume"] / 100;
        jumpSound.play();
      }
      if (this.jumpTime >= 0 || this.isChained) {
        this.isChained = true;
        this.difference = this.tileSize * Math.sin(
          this.#degToRad(
            Math.abs(this.jumpTime) * 180 / (1.5 * this.tileSize / charaSpeed)
          )
        );
      }
      if (this.jumpTime > (this.tileSize / charaSpeed) * 1.5) {
        this.difference = 0;
        this.isJunping = false;
      }
    } else if (!this.isJunping && this.isChained) {
      this.isChained = false;
    }
  }
}