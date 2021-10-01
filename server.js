import { Server } from 'https://js.sabae.cc/Server.js';
import { Client } from "https://deno.land/x/mysql/mod.ts";
import { sha512 } from "https://denopkg.com/chiefbiiko/sha512/mod.ts";

class Body extends Server {
  constructor(port) {
    super(port);
    this.client = null;
    this.connectDB();
  }
  connectDB = async () => {
    this.client = await new Client().connect({
      host: "127.0.0.1:3306",
      username: "proggame",
      db: "proggame",
      password: "proguser1143"
    });
  }
  async api(path, prm) {
    let ret = null;
    switch (path.split('/')[2]) {
      case '':
        break;

      case 'stage':
        switch (path.split('/')[3]) {
          case 'select':
            ret = await Deno.readTextFile('./stage/' + prm.name + '.json');
            break;

          case 'all':
            let retAry = [];
            for await (const dirEntry of Deno.readDir('./stage')) {
              retAry.push(dirEntry.name.split('.')[0]);
            }
            retAry.sort((a, b) => {
              return Number(a) - Number(b)
            })
            ret = JSON.stringify(retAry);
            break;
        }
        break;

      case 'user':
        switch (path.split('/')[3]) {
          case 'login': {
            const uid = prm.userid;
            let upass = encodeURI(prm.password);
            for (let i = 0; i < 100; i++) {
              upass = sha512(upass, "utf8", "hex");
            }
            const query = await this.client.query(
              "select * from users where id = \"" + uid +
              "\" and pass = \"" + upass + "\"",
            );
            if (query.length) ret = true;
            else ret = false;
            break;
          }

          case 'search': {
            const uid = prm.userid;
            const query = await this.client.query(
              "select * from users where id = \"" + uid + "\""
            );
            if (query.length) ret = true;
            else ret = false;
            break;
          }

          case 'register': {
            const uid = prm.userid;
            const uname = prm.username;
            let upass = encodeURI(prm.password);
            for (let i = 0; i < 100; i++) {
              upass = sha512(upass, "utf8", "hex");
            }

            const inserts = [
              uid, uname, upass, 0, "0", void 0
            ].map(v => {
              if (typeof v === "string") return '"' + v + '"';
              else if (typeof v === "undefined") return "current_timestamp()"
              else return v
            }).join(",");
            console.log(inserts);
            const result = await this.client.execute(
              "insert into users values(" + inserts + ")"
            );
            ret = result;
            break;
          }

          case 'free': {
            const uid = prm.userid;
            ret = await this.client.query(
              "select * from freemode_results where userid = \"" + uid + "\""
            );
            break;
          }
        }
        break;
    }
    return ret;
  }
}

new Body(4478);
