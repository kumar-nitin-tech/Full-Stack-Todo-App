const express = require('express');
const bodyParser = require("body-parser");
const app = express();
app.use(bodyParser.json());
const PORT = process.env.PORT || 3000;
const connectDb = require("./db/index");
const userAuth = require("./routes/auth");
const userAuthorization = require("./middlewares/userAuth");
const todo = require("./routes/todo");

app.use("/", userAuth);
app.use("/", userAuthorization,todo);

app.listen(PORT,()=>{
    connectDb;
    console.log(`Server is running on port ${PORT}`);
});
