import { fetchJSON } from './fetchP.js';

class GameInfo {
  #chipInfoList;

  constructor(chipInfoList) {
    this.#chipInfoList = chipInfoList;
  }

  getChipInfo = (type) => this.#chipInfoList[type];
}

class MapInfo {
  #jsondata;

  // give a parsed info
  constructor(jsondata) {
    this.#jsondata = jsondata;
  }

  // return map info object

  getMapObject = () => this.#jsondata;

  // edit map size

  addRow = () => {
    const columnWidth = this.#jsondata[0].length;
    this.#jsondata["stage"].append(Array(columnWidth).fill(0));
    this.#jsondata["param"].append(Array(columnWidth).fill(0));
  }
  removeRow = () => {
    if(this.#jsondata["stage"].length > 3){
      this.#jsondata["stage"].pop();
      this.#jsondata["param"].pop();
    }
  }

  addColumn = () => {
    this.#jsondata["stage"].forEach(row => row.push(0));
    this.#jsondata["param"].forEach(row => row.push(0));
  }
  removeColumn = () => {
    if(this.#jsondata["stage"][0].length > 3){
      this.#jsondata["stage"].forEach(row => row.pop());
      this.#jsondata["param"].forEach(row => row.pop());
    }
  }

  // edit map chip

  putChip = (x, y, type) => {
    this.#jsondata["stage"][x][y] = type;
  }
  putParam = (x, y, param) => {
    this.#jsondata["param"][x][y] = param;
  }
}

class MapRenderer {
  #selectx;
  #selecty;

  constructor() {
    this.#selectx = 0;
    this.#selecty = 0;
  }

  render = (mapInfo, ctx = new CanvasRenderingContext2D()) => {
    //
  }

  select = (x, y) => {
    this.#selectx = x;
    this.#selecty = y;
  }
}

window.onload = () => {
  const ctx = document.getElementById("map").getContext("2d");
  const stageid = (new URL(window.location.href)).searchParams.get("stageid");

}
