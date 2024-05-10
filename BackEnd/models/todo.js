const { default: mongoose } = require("mongoose");

const todoSchema = new mongoose.Schema({
    userId : {
        type : mongoose.Schema.ObjectId,
        ref : "user",
        required: true
    },
    title : {
        type : String,
        required : true
    },

    description : {
        type : String,
        required : false
    },
    completed : {
        type : Boolean,
        required : false,
        default : false
    }
}, {
    timestamps : true
});

module.exports = mongoose.model("todos", todoSchema);