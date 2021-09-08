import {fetchJSON} from 'https://js.sabae.cc/fetchJSON.js';

let moving = false;

window.onload = async () => {
  // マップ情報の取得
  const mapinfo = JSON.parse(await fetchJSON('api/stage', {'name': stagename}));
  const map = mapinfo['stage'];
  const start = mapinfo['start'];
  const hstart = mapinfo['controll'];
  const goal = mapinfo['goal'];

  let currentY = start[0];
  let currentX = start[1];
  let currentVector = start[2];

  // キャラ情報の取得
  const charaAuto = new CharaAuto(start[2]);
  const charaHand = new CharaHand('right');

  // キャラ描画用のフレーム値
  let frame = 0;
  const endFrame = 3;

  // チップ情報の取得
  const chipData = JSON.parse(await fetchJSON('api/chip', {}));
  const chipList = new ChipList(chipData);

  // tile size
  const tilesize = 64;

  // キャラ描画位置の調整
  charaAuto.setPos(
    start[0] * tilesize,
    start[1] * tilesize + charaAuto.getOffset(tilesize),
  );
  charaHand.setPos(
    hstart[0] * tilesize,
    hstart[1] * tilesize + charaHand.getOffset(tilesize),
  );

  // canvas設定
  const canvas = document.getElementById('canvas');
  canvas.width = tilesize * map[0].length; // canvasの横幅
  canvas.height = tilesize * map.length; // canvasの縦幅

  // コンテキスト取得
  const ctx = canvas.getContext('2d');

  // 描画用関数の定義
  const drawChip = (img, y, x) => {
    ctx.drawImage(
      img,
      0, 0,
      img.naturalWidth, img.naturalHeight,
      tilesize * x, tilesize * y,
      tilesize, tilesize,
    );
  };
  const drawChar = (toDraw = charaAuto, frame) => {
    const drawAsset = toDraw.getAsset(frame);
    const size = toDraw.sizeExchange(tilesize);
    charaAuto.setVector(currentVector);
    ctx.drawImage(
      drawAsset['image'],
      drawAsset['positionX'], drawAsset['positionY'],
      toDraw.getcharaX(), toDraw.getcharaY(),
      toDraw.getposX(), toDraw.getposY(),
      size['x'], size['y'],
    );
  };

  const maptileGoal = new Chip('./img/goal.png');

  function render() {
    // 移動
    /**
    可能な限り、今向いている方向に移動する
    今向いている方向が壁ならば
      逆戻りしか出来ないなら、180度旋回する
      右または左の片方が壁でないなら、そちらに旋回する
      右も左も壁でないなら、右側を優先する
        左側優先との切り替えをする方法は協議中
    */
    frame++;
    if (frame === 4 << endFrame) frame = 0;
    for (let y = 0; y < map.length; y++) {
      for (let x = 0; x < map[y].length; x++) {
        drawChip(chipList.getChip(map[y][x]), y, x);
        if (y === goal[0] && x === goal[1]) {
          drawChip(maptileGoal, y, x);
        }
      }
    }
    drawChar(charaAuto, frame >> endFrame);
    drawChar(charaHand, frame >> endFrame);
    charaAuto.moveFrame(CHARASPEED);

    if (currentY === goal[0] && currentX === goal[1] &&
      charaAuto.isWaitFor() && moving) {
      console.log('goal');
      moving = false;
    }

    if (moving) {
      const power = moveWay[currentVector]['power'];
      const nex = map[currentY + power[0]][currentX + power[1]];
      if (nex === 1) {
        if (charaAuto.isWaitFor()) {
          currentY += power[0];
          currentX += power[1];
          charaAuto.addMove(power[0] * tilesize, power[1] * tilesize);
        }
      } else if (charaAuto.isWaitFor()) {
        const leftWay = moveWay[currentVector]['lt'];
        const lst = moveWay[leftWay]['power'];
        const lnex = map[currentY + lst[0]][currentX + lst[1]];
        const rightWay = moveWay[currentVector]['rt'];
        const rst = moveWay[rightWay]['power'];
        const rnex = map[currentY + rst[0]][currentX + rst[1]];
        // left and right?
        if (lnex && rnex) {
          switch (routineAutoTwoWay) {
          case 'right':
            currentVector = rightWay;
            break;

          case 'left':
            currentVector = leftWay;
            break;
          }
        } else if (lnex) {
          currentVector = leftWay;
        } else if (rnex) {
          currentVector = rightWay;
        } else {
          currentVector = moveWay[rightWay]['rt'];
        }
      }
    }
    requestAnimationFrame(render);
  }
  requestAnimationFrame(render);
};

document.getElementById('move').onclick = () => {
  if (moving) {
    moving = false;
    document.getElementById('mode').innerText = '停止中';
  } else {
    moving = true;
    document.getElementById('mode').innerText = '移動中';
  }
};
