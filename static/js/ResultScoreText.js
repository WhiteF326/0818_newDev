const ResultScoreText = (
  lastStep, lastCost, blockCnt, dcrCnt, repeatSum, scoreTable
) => {
  const tbl = new DOMParser().parseFromString(scoreTable, "text/html");
  tbl.getElementById("baseScoreCell").innerText = String(lastCost * lastStep);
  tbl.getElementById("costCell").innerText = String(lastCost);
  tbl.getElementById("stepCell").innerText = String(lastStep);
  tbl.getElementById("penaltyCell").innerText = String(
    blockCnt * 3 + dcrCnt + repeatSum
  );
  tbl.getElementById("blockCountCell").innerText = String(blockCnt * 3);
  tbl.getElementById("dcrCountCell").innerText = String(dcrCnt);
  tbl.getElementById("loopCell").innerText = String(repeatSum);
  tbl.getElementById("finalCell").innerText = String(
    lastCost * lastStep - (blockCnt * 3 + dcrCnt + repeatSum)
  );

  return tbl.getElementsByTagName("table")[0];
}

export { ResultScoreText };
