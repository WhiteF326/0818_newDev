const lowerBound = (array = [], value = 0, first = 0, last = array.length) => {
  first -= 1;
  while(last - first > 1){
    const mid = first + Math.floor((last - first) / 2);
    if(array[mid] < value){
      first = mid;
    }else{
      last = mid;
    }
  }
  return last;
}

export { lowerBound };
