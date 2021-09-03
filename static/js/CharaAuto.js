class CharaAuto {
  constructor(vector) {
    this.charaX = 32;
    this.charaY = 48;

    this.originalImg = new Image();
    this.originalImg.setAttribute("src", "./img/charaAuto.png");

    this.vector = vector;
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

  setVector(vector){
    this.vector = vector;
  }

  getcharaX = () => this.charaX;
  getcharaY = () => this.charaY;

  sizeExchange(size) {
    return {
      "y": size,
      "x": Math.floor(size * 3 / 4)
    };
  }
  getOffset = (size) => Math.ceil(size / 8);
}