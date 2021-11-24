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
  return "残りコスト：" + (target - current);
}

// 足音
const footstepsSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/footsteps.mp3");
const footstepsSoundBase = 0.5;

// ジャンプ音
const jumpSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/jump_ver2.mp3");
const jumpSoundBase = 0.5;

// スイッチ音
const switchSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/switch.mp3");
const switchSoundBase = 1;

// こわれるゆか崩れ音
const rubbleSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/rubble.mp3");
const rubbleSoundBase = 1;

// こわれるゆか修復音
const repairSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/repair.mp3");
const repairSoundBase = 0.5;

//破壊音
const destroySound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/destroy.mp3");
const destroySoundBase = 0.5;

// 配置音
const putSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/put.mp3");
const putSoundBase = 1;

//ステージクリア音
const stageClearSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/stageclear.mp3");
const stageClearSoundBase = 1;

// 選択音
const selectSound = new Audio("https://raw.githubusercontent.com/WhiteF326/0818_newDev/master/static/audio/select.mp3");
const selectSoundBase = 1;

const floorList = [1, 3, 5, 7, 8, 9];
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

const defaultCost = {
  "move": 3,
  "destroy": 5,
  "create": 5,
  "repair": 10,
  "loop": 1,
  "if": 1,
  "twoif": 1,
}

const defaultStep = 100;

const allBlocks = [
  "move",
  "destroy",
  "create",
  "repair",
  "loop",
  "if",
  "sensor_loop",
  "sensor_loop_multiple",
  "sensor_foot_dest",
  "sensor_foot_stab",
  "sensor_foot_floor",
  "sensor_foot_colp",
  "sensor_foot_spring",
  "twoif",
];