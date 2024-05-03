const { default: mongoose } = require("mongoose");

const mongoDbConnect = async()=>{
    try{
        await mongoose.connect('mongodb+srv://nitinkumar:dLEkH8JKfaMrmXTv@todo.yizieu0.mongodb.net');
        console.log('Mongodb is connected')
    }catch(err){
        console.log(err);
        process.exit(1);
    }
};

module.exports = {mongoDbConnect};