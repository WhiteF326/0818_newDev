class ChipList {
  // マップタイル用Imageオブジェクトの生成
  constructor() {
    this.chipData = [
      ["map01.png"],
      ["map02.png"],
      ["map03.png"],
      ["spring.png"],
      ["board0.png", "board1.png", "board2.png", "board3.png"]
    ];
    this.paramFunc = [
      (p) => 0,
      (p) => 0,
      (p) => 0,
      (p) => 0,
      (p) => Math.min(3, p),
    ];
    this.stepFunc = [
      (p) => 0,
      (p) => 0,
      (p) => 0,
      (p) => 0,
      (p) => Math.max(0, p - 1),
    ];
    this.printParam = [
      (p) => "",
      (p) => "",
      (p) => "",
      (p) => "",
      (p) => String(p),
    ]
  }

  // マップタイル取得
  getChip(num = 0, param = 0) {
    const paramFixed = this.paramFunc[num](param);
    return new Chip('./img/' + this.chipData[num][paramFixed]);
  }
}
