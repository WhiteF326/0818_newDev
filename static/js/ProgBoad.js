class ProgBoad {
  constructor(gameBody) {
    this.gameBody = gameBody;
    this.costCalculator = new CostCalculator(gameBody.costList);
    this.endFlg = false;
    const workdiv = document.getElementById("blocklyDiv");
    workdiv.setAttribute("style",
      "height: " + String(floor(window.innerHeight / 2.2)) + "px; " +
      "width: " + document.getElementById("stages").innerWidth + "px;");

    this.workspace = Blockly.inject("blocklyDiv",
      { toolbox: document.getElementById("toolbox") });

    const costPrint = () => {
      const cost = this.costCalculator.calc(
        Blockly.JavaScript.workspaceToCode(this.workspace)
      );
      document.getElementById("cost").innerText = makeCostText(
        cost, gameBody.mapinfo["maxCost"]
      );
      if (cost > gameBody.mapinfo["maxCost"]) {
        document.getElementById("cost").style.color = "Red";
      } else {
        document.getElementById("cost").style.color = "Black";
      }
    }

    document.body.childNodes.forEach(elm => {
      elm.onclick = () => costPrint();
    });
    document.onkeydown = () => costPrint();
    this.workspace.addChangeListener(() => costPrint());
    costPrint();

    document.getElementById("move").onclick = () => {
      const code = Blockly.JavaScript.workspaceToCode(this.workspace)
        .replaceAll("  ", "");
      console.log(code);
      // 静的解析
      let runnable = true;
      const loopNumbers = [...code.matchAll("loop [0-9]+")]
        .map(a => [...a[0].matchAll("[0-9]+")][0])
        .map(a => Number(a[0]));
      if (loopNumbers.length) {
        if (loopNumbers.reduce((p, c) => p + c) > 50) {
          // エラーで止まる
          runnable = false;
          alert("ループ回数が多すぎます。");
        }
      }
      const illegalIf = [...code.matchAll("if[0-1]")];
      if (illegalIf.length) {
        runnable = false;
        alert("条件が指定されていないifがあります。");
      }
      const cost = this.costCalculator.calc(
        Blockly.JavaScript.workspaceToCode(this.workspace)
      );
      if (cost > this.gameBody.mapinfo["maxCost"]) {
        runnable = false;
        alert("プログラムのコストが高すぎます。");
      }
      if (runnable) {
        this.parse(code.split("\n"));
        this.gameBody.endFlg = true;
        document.getElementById("move").disabled = true;
        document.getElementById("blocklyDiv").disabled = true;
      }
    }

    // コスト表の作成
    Object.keys(progListText).forEach(eachType => {
      const value = this.gameBody.costList[eachType];

      const tr = document.createElement("tr");
      const typeD = document.createElement("td");
      typeD.appendChild(document.createTextNode(progListText[eachType]));
      tr.appendChild(typeD);
      const valueD = document.createElement("td");
      if (typeof value === 'undefined') {
        valueD.appendChild(document.createTextNode(defaultCost[eachType]));
      } else {
        valueD.appendChild(document.createTextNode(value));
      }
      valueD.setAttribute("align", "right");
      tr.appendChild(valueD);
      document.getElementById("costList").appendChild(tr);
    });
  }

  parse = (codel) => {
    for (let i = 0; i < codel.length; i++) {
      const line = codel[i];
      if (!line) continue;

      if (line.startsWith("move")) {
        const way = line.split(" ")[1];
        this.gameBody.cMove(...moveWay[way]["power"]);
      } else if (line.startsWith("destroy")) {
        this.gameBody.cAction("destroy");
      } else if (line.startsWith("create")) {
        this.gameBody.cAction("create");
      } else if (line.startsWith("loop")) {
        const loopAmount = Number(line.split(" ")[1]);
        const forid = line.split(" ")[2];
        for (let _ = 0; _ < loopAmount; _++) {
          this.parse(codel.slice(i + 1, codel.indexOf("next " + forid)));
        }
        i = codel.lastIndexOf("next " + forid);
      } else if (line.startsWith("if")) {
        const ifid = line.split(" ")[2];
        let judge = false;
        switch (line.split(" ")[1]) {
          case "sensor_foot":
            judge = this.gameBody.sensor_foot();
            console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
            break;
        }
        if (judge) {
          this.parse(codel.slice(i + 1, codel.indexOf("else " + ifid)));
        } else {
          this.parse(codel.slice(codel.indexOf("else " + ifid), codel.indexOf("endif " + ifid)))
        }
        i = codel.indexOf("endif " + ifid);
      } else if (line.startsWith("repair")) {
        this.gameBody.cAction("repair");
      }
    }
  }

  loadFromText(text) {
    this.workspace.clear();
    Blockly.Xml.domToWorkspace(
      Blockly.Xml.textToDom(text), this.workspace
    );
  }

  save() {
    localStorage.setItem(
      "savedProgram",
      Blockly.Xml.domToPrettyText(
        Blockly.Xml.workspaceToDom(this.workspace)
      )
    );
  }
}