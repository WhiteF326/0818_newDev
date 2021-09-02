import {Server} from 'https://js.sabae.cc/Server.js';

class Body extends Server {
  async api(path, prm) {
    let ret = null;
    switch (path.split('/')[2]) {
    case '':
      break;

    case 'stage':
      ret = await Deno.readTextFile('./stage/' + prm.name + '.json');
      break;
    
    case 'chip':
      ret = await Deno.readTextFile("./info/ChipList.json");
    }
    return ret;
  }
}

new Body(4478);
