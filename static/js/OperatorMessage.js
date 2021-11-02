window.addEventListener("load", async () => {
  // メッセージ番号未設定の場合
  if (!localStorage.getItem("readMessage")) {
    localStorage.setItem("readMessage", -1);
  }

  // メッセージ html を取得
  const messageDOM = new DOMParser().parseFromString(
    await (await fetch("./message.html")).text(), "text/html"
  );

  // メッセージ json を取得
  const messages = JSON.parse(
    await (await fetch("./../message/message.json")).text()
  );

  const lastMessageId = Math.max(...messages.map(r => r.id));

  // 未読判定
  if (Number(localStorage.getItem("readMessage")) < lastMessageId) {
    // 未読処理
    messageDOM.getElementById("readStatus").setAttribute(
      "src", "img/message_unread.png"
    );
  }else{
    messageDOM.getElementById("notificationMark").remove();
  }

  // ページへの追加
  document.body.appendChild(messageDOM.getElementsByTagName("table")[0]);

  // クリック時の処理
  const modalDOM = new DOMParser().parseFromString(
    await (await fetch("./messageModal.html")).text(), "text/html"
  );
  const messageModal = modalDOM.getElementById("messageModal");
  document.body.appendChild(messageModal);
  
  document.getElementById("readStatus").addEventListener("click", () => {
    messageModal.style.zIndex = 810;
    messageModal.style.opacity = 1;
    // 既読にする
    localStorage.setItem("readMessage", lastMessageId);
    document.getElementById("readStatus").setAttribute(
      "src", "img/message.png"
    );
    document.getElementById("notificationMark").remove();
  });
  messageModal.addEventListener("click", () => {
    messageModal.style.zIndex = -10000;
    messageModal.style.opacity = 0;
  });

  // テキストの追加
  document.getElementById("messageBody").appendChild(
    document.createTextNode(
      messages.find(r => r.id === lastMessageId)["body"]
    )
  );
});
