import { Server } from "https://js.sabae.cc/Server.js";

class body extends Server{
  async api(path, prm){
    let ret = null;
    switch(path.split("/")[2]){
      case "":
        break;
      
      case "stage":
        ret = await Deno.readTextFile("./stage/" + prm.name + ".json");
        break;
    }
    return ret;
  }
}

new body(4478);