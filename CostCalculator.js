class CostCalculator {
  constructor(costList) {
    this.costList = costList;
  }
  calc(code) {
    let cost = 0;

    Object.keys(defaultCost).forEach(r => {
      if (this.costList[r]) {
        cost += this.costList[r] * [...code.matchAll(r)].length;
      } else {
        cost += defaultCost[r] * [...code.matchAll(r)].length;
      }
    });

    return cost;
  }
}