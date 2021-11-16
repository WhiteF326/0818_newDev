const fetchJSON = async (path, prm) => {
  prm["path"] = path;

  const req = {
    "method": "POST",
    "mode": "cors",
    "cache": "no-cache",
    "headers": { "Content-Type": "application/json" },
    "body": JSON.stringify(prm),
  }

  const res = await fetch("http://localhost/api.php", req);

  const ret = await res.text();
  console.log(path);
  return ret;
}

export { fetchJSON };
