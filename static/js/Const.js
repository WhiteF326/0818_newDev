const stagename = 7;

const moveWay = {
  "right": {
    "power": [0, 1],
    "lt": "back",
    "right": "front"
  },
  "left": {
    "power": [0, -1],
    "lt": "front",
    "right": "back"
  },
  "back": {
    "power": [-1, 0],
    "lt": "left",
    "right": "right"
  },
  "front": {
    "power": [1, 0],
    "lt": "right",
    "right": "left"
  }
};