require("dotenv").config('./env');
const mongoDbConnect = require("./db/index");
const app = require("./app");
const PORT = process.env.PORT || process.env.DEV_PORT;


mongoDbConnect().then(() => {
    app.listen(PORT,() => {
        console.log(`Server is running at port ${PORT}`);
    })
}).catch((err) => {
    console.log("MongoDb connection failed", err);
});