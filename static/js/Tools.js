const hsv2rgb = (hsv) => {
  const h = hsv[0] / 60;
  const s = hsv[1];
  const v = hsv[2];
  if(s === 0) return [v * 255, v * 255, v * 255];

  let rgb = [];
  const i = parseInt(h);
  const f = h - i;
  const vl = [
    v * (1 - s),
    v * (1 - s * f),
    v * (1 - s * (1 - f))
  ];

  switch(i){
    case 0:
    case 6:
      rgb = [v, vl[2], vl[0]];
      break;
    
    case 1:
      rgb = [vl[1], v, vl[0]];
      break;
    
    case 2:
      rgb = [vl[0], v, vl[2]];
      break;

    case 3:
      rgb = [vl[0], vl[1], v];
      break;
    
    case 4:
      rgb = [vl[2], vl[0], v];
      break;
    
    case 5:
      rgb = [v, vl[0], vl[1]];
      break;
  }

  const rgbAry = rgb.map(v => Math.round(v * 255));
  let rgbTxt = "#";
  rgbAry.forEach(r => {
    rgbTxt += ("00" + r.toString(16)).slice(-2);
  });
  return rgbTxt;
}

const retColor = (p) => {
  const hues = Math.floor(p * 360 / 7);
  return {
    0: hsv2rgb([hues, 0.79, 0.77]),
    20: hsv2rgb([hues, 0.66, 0.93]),
    40: hsv2rgb([hues, 0.07, 0.96]),
    60: hsv2rgb([hues, 0.66, 0.93]),
    80: hsv2rgb([hues, 0.79, 0.77]),
  }
}

const retTextColor = (p) => {
  return ["white", "black", "black", "black", "black", "white", "black"][p]
}
