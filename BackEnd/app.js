const express = require("express");
const bodyParser = require("body-parser");
const app = express();
app.use(bodyParser.json());

//route imports
const user = require("./routes/auth");
const todo = require("./routes/todo");
const auth = require("./middlewares/userAuth");

//routes declaration
app.use("/api/v1/",user);
app.use("/api/v1/",auth,todo);

module.exports = app;