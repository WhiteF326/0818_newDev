// tile size
const tilesize = 32;

// canvas設定
const canvas = document.getElementById('canvas');
canvas.width = tilesize * map[0].length; // canvasの横幅
canvas.height = tilesize * map.length; // canvasの縦幅

// コンテキスト取得
const ctx = canvas.getContext('2d');

// マップタイル用Imageオブジェクトの生成
const maptileWall = new Image();
// maptile_wall.src = 'img/map01.png';
maptileWall.setAttribute('src', 'img/map01.png');

const maptileFloor = new Image();
// maptile_floor.src = 'img/map02.png';
maptileFloor.setAttribute('src', 'img/map02.png');

// マップタイルの表示
addEventListener('load', () => {
  for (let y = 0; y < map.length; y++) {
    for (let x = 0; x < map[y].length; x++) {
      if (map[y][x] === 0) {
        ctx.drawImage(
            maptileWall,
            0, 0,
            maptileWall.naturalWidth, maptileWall.naturalHeight,
            tilesize * x, tilesize * y,
            tilesize, tilesize,
        );
      }
      if (map[y][x] === 1) {
        ctx.drawImage(
            maptileFloor,
            0, 0,
            maptileFloor.naturalWidth, maptileFloor.naturalHeight,
            tilesize * x, tilesize * y,
            tilesize, tilesize,
        );
      }
    }
  }
}, false);
