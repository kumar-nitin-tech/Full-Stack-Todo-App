const user = require("../models/user");
const jsonGenerate = require("../utils/helper");
const StatusCode = require("../utils/constants");

const getAllTodos = async(req,res)=>{
    const userId = await user.findOne({email: req.user});
//    try{
        const allTodoList = await user.findById(userId._id).select("-password").populate("todos").exec()
        console.log(allTodoList);
        res.json(jsonGenerate(
            StatusCode.SUCCESS,
            "All todos",
            allTodoList
        ))
    // }catch(err){
    //     res.json(jsonGenerate(
    //         StatusCode.UNPROCESSABLE_ENTITY,
    //         "Error",
    //         err
    //     ))
    // }
}

module.exports = getAllTodos;