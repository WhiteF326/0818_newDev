class ProgBoad{
  constructor(){
    const workdiv = document.getElementById("blocklyDiv");
    workdiv.setAttribute("style", 
      "height: " + String(floor(window.innerHeight / 2.2)) + "px; " +
      "width: " + String(floor(window.innerWidth / 1.2)) + "px;");

    const workspace = Blockly.inject("blocklyDiv",
      {toolbox: document.getElementById("toolbox")});
    
    document.getElementById("move").onclick = () => {
      const code = Blockly.JavaScript.workspaceToCode(workspace);
      console.log(code);
    }
  }
}