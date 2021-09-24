class ChipList {
  // マップタイル用Imageオブジェクトの生成
  constructor() {
    this.chipData = [
      ["map01.png"],
      ["map02.png"],
      ["map03.png"],
      ["spring.png"],
      ["board0.png", "board1.png", "board2.png", "board3.png"],
      ["switch1.png", "switch2.png", "switch3.png", "switch4.png", "switch5.png"],
      ["door_off1.png", "door_off2.png", "door_off3.png", "door_off4.png", "door_off5.png"],
      ["pushed1.png", "pushed2.png", "pushed3.png", "pushed4.png", "pushed5.png"],
      ["door_on1.png", "door_on2.png", "door_on3.png", "door_on4.png", "door_on5.png"],
      ["avoidCreate.png"]
    ];
    this.paramFunc = [
      (p) => 0,
      (p) => 0,
      (p) => 0,
      (p) => 0,
      (p) => Math.min(3, p),
      (p) => p,
      (p) => p,
      (p) => p,
      (p) => p,
      (p) => 0,
    ];
    this.stepFunc = [
      (p) => 0,
      (p) => 0,
      (p) => 0,
      (p) => 0,
      (p) => Math.max(0, p - 1),
      (p) => p,
      (p) => p,
      (p) => p,
      (p) => p,
      (p) => p,
    ];
    this.printParam = [
      (p) => "",
      (p) => "",
      (p) => "",
      (p) => "",
      (p) => String(p),
      (p) => "",
      (p) => "",
      (p) => "",
      (p) => "",
      (p) => "",
    ];
  }

  // マップタイル取得
  getChip(num = 0, param = 0) {
    const paramFixed = this.paramFunc[num](param);
    return new Chip('./img/' + this.chipData[num][paramFixed]);
  }
}
