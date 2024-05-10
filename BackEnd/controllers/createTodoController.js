const validateTodo = require("../validateSchemas/todoSchema");
const userTodo = require("../models/todo");
const user = require("../models/user");
const jsonGenerate = require("../utils/helper");
const StatusCode = require("../utils/constants");

const createTodo = async(req,res)=>{
    const responseTodo = validateTodo.safeParse(req.body);
    if(!responseTodo.success){
        res.json(jsonGenerate(
            StatusCode.VALIDATION_ERROR,
            "Enter the valid Todo",
        ))
    }
    const userId = await user.findOne({email : req.user});
    const todo = await userTodo.create({
        userId: userId._id,
        title : req.body.title,
        description : req.body.description,
        completed : req.body.completed
    })
    if(todo){
        const todoList = await user.findOneAndUpdate({
            _id : userId._id
        },{
            $push : {todos : todo}
        })
        return res.json(
            jsonGenerate(
                StatusCode.SUCCESS,
                "Todo Created Successfully",
                {
                    userId : userId._id,
                    todo: todo
                }
            )
        )
    }
}

module.exports = createTodo;