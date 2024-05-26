const todo = require("../models/todo");
const user = require("../models/user");
const jsonGenerate = require("../utils/helper");

//We take todo id to find the todo in user id 
const deleteTodo = async(req, res)=>{
    const userId = await user.findOne({email: req.user});
    try{
        const userTodo = await todo.findOneAndDelete(
            {
                _id: req.body._id,
                userId : userId._id
            }
        );
        if(userTodo){
            const userUpdate = await user.findOneAndUpdate(
                {
                    _id: userId._id
                },
                {
                    $pull: {todos: req.body._id}
                }
            );
        }
        res.json(jsonGenerate(
            "success",
            {
                msg: "Task is deleted successfully"
            }
        ))
    }catch(err){
        res.json(jsonGenerate(
            "Error",
            {
                error: "Task is not updated"
            }
        ))
    }
}

module.exports = deleteTodo;