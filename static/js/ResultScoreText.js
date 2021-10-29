const ResultScoreText = (
  lastStep, lastCost, blockCnt, dcrCnt, repeatSum, scoreTable
) => {
  const tbl = new DOMParser().parseFromString(scoreTable, "text/html");
  tbl.getElementById("baseScoreCell").innerText = String(lastCost * lastStep);
  tbl.getElementById("costCell").innerText = String(lastCost);
  tbl.getElementById("stepCell").innerText = String(lastStep);
  tbl.getElementById("penaltyCell").innerText = String(
    blockCnt * 15 + dcrCnt * 12 + repeatSum * 2
  );
  tbl.getElementById("blockCountCell").innerText = String(blockCnt * 15);
  tbl.getElementById("dcrCountCell").innerText = String(dcrCnt * 12);
  tbl.getElementById("loopCell").innerText = String(repeatSum * 2);
  tbl.getElementById("finalCell").innerText = String(
    lastCost * lastStep - (blockCnt * 15 + dcrCnt * 12 + repeatSum * 2)
  );

  return tbl.getElementsByTagName("table")[0];
}

export { ResultScoreText };
