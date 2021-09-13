class CostCalculator{
  constructor(){
    //
  }
  calc(code){
    let cost = 0;
    // move
    cost += 3 * [...code.matchAll("move")].length;

    // destroy
    cost += 5 * [...code.matchAll("destroy")].length;
    // create
    cost += 5 * [...code.matchAll("create")].length;
    
    // loop
    cost += [...code.matchAll("loop")].length;
    // if
    cost += [...code.matchAll("if")].length;

    return cost;
  }
}