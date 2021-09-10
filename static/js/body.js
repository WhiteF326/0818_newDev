import { fetchJSON } from 'https://js.sabae.cc/fetchJSON.js';

let moving = false;

class Body{
  constructor(mapinfo){
    // プログラム部の表示
    new ProgBoad();
    // マップ情報の取得
    this.mapinfo = mapinfo;
    this.map = this.mapinfo['stage'];
    this.start = this.mapinfo['start'];
    this.hstart = this.mapinfo['controll'];
    this.goal = this.mapinfo['goal'];

    // 白キャラの初期位置と向きを設定
    this.currentY = this.start[0];
    this.currentX = this.start[1];
    this.currentVector = this.start[2];

    // プログラム板の初期化
    this.progSize = this.mapinfo['progSize'];

    // キャラ情報の取得
    this.charaAuto = new CharaAuto(this.start[2]);
    this.charaHand = new CharaHand('right');

    // キャラ描画用のフレーム値
    this.frame = 0;
    this.endFrame = 3;

    // チップ情報の取得
    this.chipData = [
      "map01.png",
      "map02.png",
      "map03.png"
    ];
    this.chipList = new ChipList(this.chipData);

    // ウィンドウサイズを取得
    this.sw = window.innerWidth;

    // tile size
    this.tilesize = min(
      64, floor(this.sw / 2.2 / this.map[0].length));

    // キャラ描画位置の調整
    this.charaAuto.setPos(
      this.start[0] * this.tilesize,
      this.start[1] * this.tilesize
        + this.charaAuto.getOffset(this.tilesize),
    );
    this.charaHand.setPos(
      this.hstart[0] * this.tilesize,
      this.hstart[1] * this.tilesize
        + this.charaHand.getOffset(this.tilesize),
    );

    // canvas設定
    this.canvas = document.getElementById('canvas');
    this.canvas.width = this.tilesize * this.map[0].length; // canvasの横幅
    this.canvas.height = this.tilesize * this.map.length; // canvasの縦幅

    // コンテキスト取得
    this.ctx = this.canvas.getContext('2d');

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

    this.render();
  }

  render() {
    // キャラクターの移動
    this.frame++;
    if (this.frame === 4 << this.endFrame) this.frame = 0;
    for (let y = 0; y < this.map.length; y++) {
      for (let x = 0; x < this.map[y].length; x++) {
        this.drawChip(this.chipList.getChip(this.map[y][x]), y, x);
        if (y === this.goal[0] && x === this.goal[1]) {
          this.drawChip(this.maptileGoal, y, x);
        }
      }
    }
    this.drawChar(this.charaAuto, this.frame >> this.endFrame);
    this.drawChar(this.charaHand, this.frame >> this.endFrame);
    this.charaAuto.moveFrame(CHARASPEED);

    if (this.currentY === this.goal[0] && this.currentX === this.goal[1] &&
      this.charaAuto.isWaitFor() && moving) {
      console.log('goal');
      moving = false;
    }

    if (moving) {
      const power = moveWay[currentVector]['power'];
      const nex = this.map[currentY + power[0]][currentX + power[1]];
      if (nex === 1) {
        if (this.charaAuto.isWaitFor()) {
          this.currentY += power[0];
          this.currentX += power[1];
          this.charaAuto.addMove(
            power[0] * this.tilesize, power[1] * this.tilesize
          );
        }
      } else if (this.charaAuto.isWaitFor()) {
        const leftWay = moveWay[currentVector]['lt'];
        const lst = moveWay[leftWay]['power'];
        const lnex = map[currentY + lst[0]][this.currentX + lst[1]];
        const rightWay = moveWay[currentVector]['rt'];
        const rst = moveWay[rightWay]['power'];
        const rnex = map[currentY + rst[0]][this.currentX + rst[1]];
        // left and right?
        if (lnex === 1 && rnex === 1) {
          switch (routineAutoTwoWay) {
            case 'right':
              this.currentVector = rightWay;
              break;

            case 'left':
              this.currentVector = leftWay;
              break;
          }
        } else if (lnex === 1) {
          this.currentVector = leftWay;
        } else if (rnex === 1) {
          this.currentVector = rightWay;
        } else {
          this.currentVector = moveWay[rightWay]['rt'];
        }
      }
    }
    requestAnimationFrame(this.render.bind(this));
  }
}

window.onload = async () => {
  const mapinfo = JSON.parse(await fetchJSON('api/stage', { 'name': stagename }));
  new Body(mapinfo);
}