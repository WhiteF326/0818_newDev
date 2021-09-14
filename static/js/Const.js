<<<<<<< HEAD
const stagename = 22;
=======
const stagename = 8;
>>>>>>> 2f595fc7b685690beb19373cdd821bb4b5067172
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