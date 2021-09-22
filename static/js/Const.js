const stagename = 7;
const CHARASPEED = 4;

const routineAutoTwoWay = "right";

const moveWay = {
  "right": {
    "power": [0, 1],
    "lt": "back",
    "rt": "front"
  },
  "left": {
    "power": [0, -1],
    "lt": "front",
    "rt": "back"
  },
  "back": {
    "power": [-1, 0],
    "lt": "left",
    "rt": "right"
  },
  "front": {
    "power": [1, 0],
    "lt": "right",
    "rt": "left"
  }
};

const floor = Math.floor
const min = Math.min
const max = Math.max

const makeCostText = (current, target) => {
  return "現在コスト：" + current + "\n最大コスト：" + target;
}

//ジャンプ音
const jumpSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/jump.mp3");
jumpSound.volume = 1;

//スイッチ音
const switchSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/switch.mp3");
switchSound.volume = 1;

const floorList = [1, 3, 4, 5, 7, 8];
const contains = (ary, elm) => {
  let high = ary.length - 1;
  let low = 0;
  let mid = 0;

  while (low <= high) {
    mid = Math.floor((high + low) / 2);
    if (ary[mid] === elm) {
      return true;
    } else if (elm > ary[mid]) {
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  }

  return false;
}