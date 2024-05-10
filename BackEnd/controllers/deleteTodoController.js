const todo = require("../models/todo");
const user = require("../models/user");
const StatusCode = require("../utils/constants");
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
            StatusCode.SUCCESS,
            "Task is deleted successfully"
        ))
    }catch(err){
        res.json(jsonGenerate(
            StatusCode.UNPROCESSABLE_ENTITY,
            "Task is not updated !!",
            null
        ))
    }
}

module.exports = deleteTodo;