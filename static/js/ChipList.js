class ChipList {
  // マップタイル用Imageオブジェクトの生成
  constructor(chipData) {
    this.chipData = chipData;
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
      (p) => 0,
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
      (p) => "",
    ];
  }

  // マップタイル取得
  getChip(num = 0, param = 0) {
    const paramFixed = this.paramFunc[num](param);
    return new Chip('./img/' + this.chipData[num][paramFixed]);
  }
}
