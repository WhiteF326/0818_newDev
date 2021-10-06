const fetchJSON = async (path, prm) => {
  prm["path"] = path;

  const req = {
    "method": "POST",
    "mode": "cors",
    "cache": "no-cache",
    "headers": { "Content-Type": "application/json" },
    "body": JSON.stringify(prm),
  }

  console.log(prm);
  const res = await (await fetch("http://localhost/test.php", req)).text();
  return res;
}

console.log(await fetchJSON("api/fuck", {"userid": "test", "password": "test"}));
