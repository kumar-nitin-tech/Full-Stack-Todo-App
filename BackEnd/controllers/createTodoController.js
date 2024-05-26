const validateTodo = require("../validateSchemas/todoSchema");
const userTodo = require("../models/todo");
const user = require("../models/user");
const jsonGenerate = require("../utils/helper");

const createTodo = async(req,res)=>{
    const responseTodo = validateTodo.safeParse(req.body);
    if(!responseTodo.success){
        res.status(400).json(jsonGenerate(
            "Error",
            {
                error: "Enter the valid todo"
            }
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
        return res.status(200).json(
            jsonGenerate(
                "Todo Created Successfully",
                {
                    todo: todo
                }
            )
        )
    }
}

module.exports = createTodo;