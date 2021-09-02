class ChipList {
  // マップタイル用Imageオブジェクトの生成
  constructor(chipData) {
    this.chipData = chipData;
  }

  // マップタイル取得
  getChip(num = 0){
    return new Chip("./img/" + this.chipData[num]);
  }
}