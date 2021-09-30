window.addEventListener("load", () => {
  const inf = document.getElementById("accountInfo");
  inf.setAttribute(
    "style", "width: " + String(document.body.clientWidth) + "px;"
  );

  const def = document.createElement("span");
  def.classList.add("left");

  const inout = document.createElement("span");
  inout.classList.add("right");

  if (localStorage.getItem("userid")) {
    def.appendChild(document.createTextNode(
      localStorage.getItem("username") + " 様　ログイン中"
    ));
    const logoutLink = document.createElement("a");
    logoutLink.appendChild(document.createTextNode("ログアウト"));
    logoutLink.href = "logout.html";
    inout.appendChild(logoutLink);
  } else {
    def.appendChild(document.createTextNode("未ログイン"));
    const loginLink = document.createElement("a");
    loginLink.appendChild(document.createTextNode("ログイン"));
    loginLink.href = "login.html";
    inout.appendChild(loginLink);
  }
  def.style.display = "block";

  inf.appendChild(def);
  inf.appendChild(inout);
});

window.addEventListener("scroll", () => {
  
});
