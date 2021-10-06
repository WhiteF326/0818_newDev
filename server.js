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
      hostname: "localhost",
      username: "LAA1355306",
      db: "LAA1355306-proggame",
      password: Deno.env.get("dbPassword")
    });
  }
  async api(path, prm) {
    let ret = null;
    switch (path.split('/')[2]) {
      case '':
        break;

      case 'stage':
        switch (path.split('/')[3]) {
          case 'select': {
            const stagename = prm.name;
            try {
              ret = await Deno.readTextFile('./stage/' + stagename + '.json');
            } catch {
              const first = {
                "stage": [
                  [0, 0, 0],
                  [0, 1, 0],
                  [0, 0, 0]
                ],
                "param": [
                  [0, 0, 0],
                  [0, 0, 0],
                  [0, 0, 0]
                ],
                "start": [1, 1, "right"],
                "goal": [1, 1],
                "controll": [0, 0],
                "costList": {
                  "move": 3,
                  "destroy": 5,
                  "create": 5,
                  "repair": 10,
                  "loop": 1,
                  "if": 1
                },
                "maxCost": 10,
                "maxStep": 10,
                "unlocked": [
                  "move",
                  "destroy",
                  "create",
                  "repair",
                  "loop",
                  "if",
                  "sensor_loop",
                  "sensor_foot_dest",
                  "sensor_foot_stab",
                  "sensor_foot_floor",
                  "sensor_foot_colp"
                ]
              };
              await Deno.writeTextFile("./stage/" + stagename + ".json",
                JSON.stringify(first));
              ret = JSON.stringify(first);
            }
            break;
          }

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

          case 'clear':
            console.log(prm);
            const uid = prm.userid;
            const stagename = prm.stagename;
            const cost = prm.cost;
            const prms = "null, " + [
              uid, stagename, 0, cost, void 0, 0
            ].map(v => {
              if (typeof v === "string") return '"' + v + '"';
              else if (typeof v === "undefined") return "current_timestamp()"
              else return v
            }).join(",");
            console.log(prms);
            await this.client.execute(
              "insert into freemode_results values(" + prms + ")"
            );
            break;

          case 'save': {
            const prmv = JSON.stringify(prm.problem);
            await Deno.writeTextFile("./stage/" + prm.name + ".json", prmv);
            break;
          }
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
            if (query.length) ret = query[0]["name"];
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
              uid, uname, upass, 0, void 0
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
              "select * from freemode_results "
              + "where userid = \"" + uid + "\" and deleted = 0"
            );
            break;
          }

          case 'reset': {
            const uid = prm.userid;
            switch (path.split('/')[4]) {
              case 'free':
                await this.client.execute(
                  "update freemode_results set deleted = 1 " +
                  "where userid = \"" + uid + "\""
                );
                break;

              case 'story':
                await this.client.execute(
                  "update users set story = 0 where userid = \"" + uid + "\""
                );
                break;
            }
          }
        }

      case 'story': {
        switch (path.split('/')[3]) {
          case 'select': {
            const uid = prm.userid;
            const progress = (await this.client.query(
              "select story_progress from users where id = \"" + uid + "\""
            ));
            const stageNo = Number(progress[0]["story_progress"]) + 1;
            try {
              ret = await Deno.readTextFile('./story/' + stageNo + '.json');
            } catch {
              ret = false;
            }
            break;
          }

          case 'getProgress': {
            const uid = prm.userid;
            const progress = (await this.client.query(
              "select story_progress from users where id = \"" + uid + "\""
            ));
            ret = progress[0]["story_progress"];
            break;
          }

          case 'abort': {
            const uid = prm.userid;
            const progress = (await this.client.query(
              "select story_progress from users where id = \"" + uid + "\""
            ));
            const progNo = progress[0]["story_progress"];
            this.client.execute(
              "update users set story_progress = " + (progNo - 1)
              + " where id = \"" + uid + "\""
            );
            break;
          }
        }
        break;
      }
    }
    return ret;
  }
}

new Body(4478);
