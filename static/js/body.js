import {fetchJSON} from 'https://js.sabae.cc/fetchJSON.js';
window.onload = async () => {
  // get map
  const stagename = 7;

  // マップ情報の取得
  const mapinfo = JSON.parse(await fetchJSON('api/stage', {'name': stagename}));
  const map = mapinfo['stage'];
  const start = mapinfo['start'];
  const goal = mapinfo['goal'];

  // チップ情報の取得
  const chipData = JSON.parse(await fetchJSON('api/chip', {}));
  const chipList = new ChipList(chipData);

  // tile size
  const tilesize = 32;

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

  const maptileStart = new Chip('./img/start.png');
  const maptileGoal = new Chip('./img/goal.png');

  function render() {
    for (let y = 0; y < map.length; y++) {
      for (let x = 0; x < map[y].length; x++) {
        drawChip(chipList.getChip(map[y][x]), y, x);
        if (y === start[0] && x === start[1]) {
          drawChip(maptileStart, y, x);
        }
        if (y === goal[0] && x === goal[1]) {
          drawChip(maptileGoal, y, x);
        }
      }
    }
    requestAnimationFrame(render);
  }

  requestAnimationFrame(render);
};
