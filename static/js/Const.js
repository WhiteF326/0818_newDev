const stagename = 6;
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