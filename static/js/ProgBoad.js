class ProgBoad{
  constructor(){
    const workdiv = document.getElementById("blocklyDiv");
    workdiv.setAttribute("style", 
      "height: " + String(floor(window.innerHeight / 2)) + "px; " +
      "width: " + String(floor(window.innerWidth / 2.2)) + "px;");
    
    const workspace = Blockly.inject("blocklyDiv",
      {toolbox: document.getElementById("toolbox")});
  }
}