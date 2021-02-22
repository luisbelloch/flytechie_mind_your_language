const chalk = require("chalk");
const fetch = require("node-fetch");
const NATS = require("nats");
const nats = NATS.connect({ servers: ["nats://127.0.0.1:4222"] });

process.on("SIGINT", () => {
  console.log("\nClosing connections...");
  nats.flush();
  nats.close();
  process.exit();
});

let msgId = 0;
const nextColor = () => {
  msgId = msgId + 5;
  return chalk.hsv(msgId % 360, 100, 100);
}

const Iterfable = {
  send: (event, color) => {
    fetch("http://127.0.0.1:3000/email", {
      method: "post",
      body: JSON.stringify(event),
      headers: { "Content-Type": "application/json" },
    }).finally(() => process.stdout.write(color.bold("●")));
  },
};

nats.subscribe(`pancake.*`, (text, reply, subject) => {
  const color = nextColor();
  process.stdout.write(color.bold("○"));
  const message = JSON.parse(text);
  Iterfable.send(message, color);
});
