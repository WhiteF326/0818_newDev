const hsv2rgb = (hsv) => {
  const h = hsv[0] / 60;
  const s = hsv[1];
  const v = hsv[2] >= 1 ? 1 : hsv[2];
  if (s === 0) return (
    "#" + [v * 255, v * 255, v * 255].map(r => r.toString(16)).join()
  );

  let rgb = [];
  const i = parseInt(h);
  const f = h - i;
  const vl = [
    v * (1 - s),
    v * (1 - s * f),
    v * (1 - s * (1 - f))
  ];

  switch (i) {
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

const hues = (p, e) => {
  return 120 - Math.floor(120 / (e - 1)) * p;
}

const retColor = (p, e, d) => {
  const sdiff = d >= 6 ? 0.10 : 0;
  return {
    0: hsv2rgb([hues(p, e), 0.79, 0.77 + sdiff]),
    20: hsv2rgb([hues(p, e), 0.66, 0.93 + sdiff]),
    40: hsv2rgb([hues(p, e), 0.07, 0.96 + sdiff]),
    60: hsv2rgb([hues(p, e), 0.66, 0.93 + sdiff]),
    80: hsv2rgb([hues(p, e), 0.79, 0.77 + sdiff]),
  }
}

const retTextColor = (p, e, d) => {
  if(hues(p, e) >= 40 && hues(p, e) <= 110) return "#000000";
  return "#FFFFFF";
}
