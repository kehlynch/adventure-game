// @flow

const express = require("express");
const next = require("next");
const compression = require("compression");
const sslRedirect = require("heroku-ssl-redirect");

const port = process.env.PORT || "";
const dev = process.env.NODE_ENV !== "production";
const app = next({ dev });
const handle = app.getRequestHandler();

async function start() {
  try {
    await app.prepare();
  } catch (err) {
    console.error(err.stack);
    process.exit(1);
  }

  const server = express();

  server.use(compression());
  server.use(sslRedirect());

  server.get("*", (req, res) => handle(req, res));

  server.listen(port, err => {
    if (err) throw err;
    console.log(`> Ready on http://localhost:${port.toString()}`);
  });
}

start();
