const { default: mongoose } = require("mongoose");

const todoSchema = new mongoose.Schema({
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
    },
    user : {
        type : mongoose.Schema.ObjectId,
        ref : "User",
        required: true
    }
}, {
    timestamps : true
});

module.exports = mongoose.model("todo", todoSchema);