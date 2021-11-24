class ProgBoad {
  constructor(gameBody) {
    this.gameBody = gameBody;
    this.costCalculator = new CostCalculator(gameBody.costList);
    this.endFlg = false;
    const workdiv = document.getElementById("blocklyDiv");
    workdiv.setAttribute("style",
      "height: " + String(floor(window.innerHeight / 2) - 8) + "px; " +
      "width: " + document.getElementById("stages").innerWidth + "px;");
    // 解禁済みブロックの適用
    if (gameBody.mapinfo['unlocked']) {
      gameBody.mapinfo['unlocked'].forEach(r => {
        const block = document.createElement("block");
        block.setAttribute("type", r);
        document.getElementById("toolbox").appendChild(block);
      });
    } else {
      allBlocks.forEach(r => {
        const block = document.createElement("block");
        block.setAttribute("type", r);
        document.getElementById("toolbox").appendChild(block);
      });
    }
    const toolbox = document.getElementById("toolbox")
    this.workspace = Blockly.inject("blocklyDiv",
      { toolbox: toolbox });

    const costPrint = () => {
      const cost = this.costCalculator.calc(
        Blockly.JavaScript.workspaceToCode(this.workspace)
      );
      document.getElementById("cost").innerText = makeCostText(
        cost, gameBody.mapinfo["maxCost"]
      );
      document.getElementById("cost").style.fontFamily = "cursive";
      document.getElementById("cost").style.textShadow = "1px 1px 1px white";
      document.getElementById("cost").style.borderBlockEndStyle = "dashed";
      document.getElementById("cost").style.borderBlockColor = "grey";
      if (cost > gameBody.mapinfo["maxCost"]) {
        document.getElementById("cost").style.color = "Red";
      } else {
        document.getElementById("cost").style.color = "black";
      }
    }

    this.loopCounters = [];

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
      const loopNumbers = [...code.matchAll("_*loop [0-9]+")]
        .map(a => a[0].indexOf("_") === -1 ? a : ["loop 0"])
        .map(a => [...a[0].matchAll("[0-9]+")][0])
        .map(a => Number(a[0]));
      if (loopNumbers.length) {
        if (loopNumbers.reduce((p, c) => p + c) > 50) {
          // エラーで止まる
          runnable = false;
          alert("くりかえしのループ回数が多すぎます。");
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
        document.getElementById("help").disabled = true;
        if (localStorage.getItem("gameEnabled") === "free") {
          document.getElementById("backToSelect").disabled = true;
        } else if (localStorage.getItem("gameEnabled") === "story") {
          document.getElementById("backToTop").disabled = true;
        }
        document.getElementById("blocklyDiv").disabled = true;
      }
    }

    // コスト表の作成
    Object.keys(defaultCost).forEach(eachType => {
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

  costCalculate = () => {
    return this.costCalculator.calc(
      Blockly.JavaScript.workspaceToCode(this.workspace)
    );
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
        for (let j = 0; j < loopAmount; j++) {
          this.loopCounters.push(j);
          this.parse(codel.slice(i + 1, codel.indexOf("next " + forid)));
          this.loopCounters.pop();
        }
        i = codel.lastIndexOf("next " + forid);
      } else if (line.startsWith("if")) {
        const ifid = line.split(" ").slice(-1)[0];
        let judge = false;
        switch (line.split(" ")[1]) {
          case "sensor_foot_dest":
            judge = this.gameBody.sensor_foot([2, 10]);
            // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
            break;
          case "sensor_foot_stab":
            judge = this.gameBody.sensor_foot([0]);
            // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
            break;
          case "sensor_foot_floor":
            judge = this.gameBody.sensor_foot([1]);
            // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
            break;
          case "sensor_foot_colp":
            judge = this.gameBody.sensor_foot([4]);
            // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
            break;
          case "sensor_foot_spring":
            judge = this.gameBody.sensor_foot([3]);
            // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
            break;
          case "sensor_loop":
            const comp = Number(line.split(" ")[2]);
            judge = comp - 1 <= this.loopCounters.slice(-1)[0];
            break;
          case "sensor_loop_multiple": {
            const comp = Number(line.split(" ")[2]);
            judge = ((this.loopCounters.slice(-1)[0] + 1) % comp) === 0;
            break;
          }
        }
        if (judge) {
          this.parse(codel.slice(i + 1, codel.indexOf("else " + ifid)));
        } else {
          this.parse(codel.slice(
            codel.indexOf("else " + ifid), codel.indexOf("endif " + ifid)
          ));
        }
        i = codel.indexOf("endif " + ifid);
      } else if (line.startsWith("repair")) {
        this.gameBody.cAction("repair");
      } else if (line.startsWith("twoif")) {
        const ifid = line.split(" ").slice(-1)[0];
        let judge = new Array(2).fill(false);
        for (let i = 0; i < 2; i++) {
          switch (line.split(" ")[1 + i * 2]) {
            case "sensor_foot_dest":
              judge[i] = this.gameBody.sensor_foot([2, 10]);
              // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
              break;
            case "sensor_foot_stab":
              judge[i] = this.gameBody.sensor_foot([0]);
              // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
              break;
            case "sensor_foot_floor":
              judge[i] = this.gameBody.sensor_foot([1]);
              // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
              break;
            case "sensor_foot_colp":
              judge[i] = this.gameBody.sensor_foot([4]);
              // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
              break;
            case "sensor_foot_spring":
              judge[i] = this.gameBody.sensor_foot([3]);
              // console.log(this.gameBody.cursorX, this.gameBody.cursorY, judge);
              break;
            case "sensor_loop": {
              const comp = Number(line.split(" ")[2]);
              judge[i] = comp - 1 <= this.loopCounters.slice(-1)[0];
              break;
            }
            case "sensor_loop_multiple": {
              const comp = Number(line.split(" ")[2]);
              judge[i] = ((this.loopCounters.slice(-1)[0] + 1) % comp) === 0;
              break;
            }
          }
        }
        const total = judge.reduce((a, b) => {
          if (line.split(" ")[2] === "AND") return a & b;
          else return a | b;
        });
        console.log(judge, total);
        if (total) {
          this.parse(codel.slice(i + 1, codel.indexOf("else " + ifid)));
        } else {
          this.parse(codel.slice(
            codel.indexOf("else " + ifid), codel.indexOf("endif " + ifid)
          ));
        }
        i = codel.indexOf("endif " + ifid);
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
    const stageNo = localStorage.getItem("selectedStage");
    localStorage.setItem(
      "savedProgram" + stageNo,
      Blockly.Xml.domToPrettyText(
        Blockly.Xml.workspaceToDom(this.workspace)
      )
    );
  }

  calculateLastCost = () => {
    return this.gameBody.mapinfo["maxCost"] - this.costCalculate();
  }

  getXML = () => {
    return Blockly.Xml.domToPrettyText(
      Blockly.Xml.workspaceToDom(this.workspace)
    );
  }
}