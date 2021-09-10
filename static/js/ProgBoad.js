class ProgBoad {
  constructor(gameBody) {
    this.gameBody = gameBody;
    const workdiv = document.getElementById("blocklyDiv");
    workdiv.setAttribute("style",
      "height: " + String(floor(window.innerHeight / 2.2)) + "px; " +
      "width: " + String(floor(window.innerWidth / 1.2)) + "px;");

    const workspace = Blockly.inject("blocklyDiv",
      { toolbox: document.getElementById("toolbox") });

    document.getElementById("move").onclick = () => {
      const code = Blockly.JavaScript.workspaceToCode(workspace)
        .replaceAll("  ", "");
      this.repl(code.split("\n"));
    }
  }

  repl = (codel) => {
    for(let i = 0; i < codel.length; i++){
      const line = codel[i];
      if(!line) continue;
      console.log(line.split(" "));

      if(line.startsWith("move")){
        const way = line.split(" ")[1];
        this.gameBody.cmove(...moveWay[way]["power"]);
      }else if(line.startsWith("destroy")){
        this.gameBody.destroyCursor();
      }else if(line.startsWith("create")){
        this.gameBody.createCursor();
      }else if(line.startsWith("loop")){
        const loopAmount = Number(line.split(" ")[1]);
        for(let _ = 0; _ < loopAmount; _++){
          this.repl(codel.slice(i + 1, codel.lastIndexOf("next")));
        }
        i = codel.lastIndexOf("next");
      }else if(line.startsWith("if")){
        const ifid = line.split(" ")[2];
        let judge = false;
        switch(line.split(" ")[1]){
          case "sensor_foot":
            judge = this.gameBody.sensor_foot();
            break;
        }
        if(judge){
          this.repl(codel.slice(i + 1, codel.indexOf("else " + ifid)));
        }else{
          this.repl(codel.slice(codel.indexOf("else " + ifid), codel.indexOf("endif " + ifid)))
        }
        i = codel.indexOf("endif " + ifid);
      }
    }
  }
}