const user = require("../models/user");
const jsonGenerate = require("../utils/helper");

const getAllTodos = async(req,res)=>{
    const userId = await user.findOne({email: req.user});
    try{
        const allTodoList = await user.findById(userId._id).select("-password").populate("todos").exec()
        console.log(allTodoList);
        res.status(200).json(jsonGenerate(
            "All todos success",
            allTodoList
        ))
    }catch(err){
        res.status(404).json(jsonGenerate(
            "Error",
            {
                error : err
            }
        ))
    }
}

module.exports = getAllTodos;