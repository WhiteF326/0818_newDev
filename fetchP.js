const fetchJSON = async (path, prm) => {
  prm["path"] = path;

  console.log(path);

  const req = {
    "method": "POST",
    "mode": "cors",
    "cache": "no-cache",
    "headers": { "Content-Type": "application/json" },
    "body": JSON.stringify(prm),
  }

  const res = await (await fetch("http://fkiohr-blockln.main.jp/api.php", req)).text();
  return res;
}

export { fetchJSON };
