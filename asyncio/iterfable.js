const express = require("express");
const app = express();
const port = 3000;

function rnd(min, max) {
  return Math.floor(Math.random() * (max - min + 1) + min);
}

app.post("/email", (request, response) => {
  setTimeout(() => {
    response.send('{"ok":true}');
  }, rnd(100, 500));
});

app.listen(3000, (err) => {
  console.log(`Server is listening on ${port}`);
});
