class Doors{
  constructor(ary){
    this.last = ary;
  }

  pushed(ptr){
    this.last[ptr] = max(0, this.last[ptr] - 1);
    // console.log(this.last);
    if(!this.last[ptr]){
      return true;
    }else{
      return false;
    }
  }
}