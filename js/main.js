//canvas設定
let canvas = document.getElementById('canvas');
canvas.width = 288;		//canvasの横幅
canvas.height = 288;	//canvasの縦幅

//コンテキスト取得
let ctx = canvas.getContext('2d');

//マップタイル用Imageオブジェクトの生成
let maptile_wall = new Image();
maptile_wall.src = 'img/map01.png';

let maptile_floor = new Image();
maptile_floor.src = 'img/map02.png';

//マップ
document.write("<script src='map.js'></script>");

//マップタイルの表示
addEventListener('load', function () {
    for (let y = 0; y < map.length; y++) {
        for (let x = 0; x < map[y].length; x++) {
            if (map[y][x] === 0) ctx.drawImage(maptile_wall, 0, 0, 32, 32, 32 * x, 32 * y, 32, 32);
            if (map[y][x] === 1) ctx.drawImage(maptile_floor, 0, 0, 32, 32, 32 * x, 32 * y, 32, 32);
        }
    }
}, false);