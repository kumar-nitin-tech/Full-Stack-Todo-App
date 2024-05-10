const mongoose = require("mongoose");

const mongoDbConnect = async() => {
    try{
        const connectionInstance = await mongoose.connect(process.env.MONGODB_URI);
        console.log(`\n MongoDb is connected with host ${connectionInstance.connection.host}`);
    }catch(error){
        console.error("MongoDB connection is failed", error);
        process.exit(1);
    }
}

module.exports = mongoDbConnect;