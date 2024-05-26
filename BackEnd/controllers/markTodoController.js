const  z  = require("zod");
const todo = require("../models/todo");
const user = require("../models/user");
const jsonGenerate = require("../utils/helper");

//We take todo id to find the todo in user id 
const markTodo = async(req, res)=>{
    const userId = await user.findOne({email: req.user});
    const booleanSchema = z.boolean();
    const validate = booleanSchema.safeParse(req.body.completed);
    if(!validate.success){
        return res.json(jsonGenerate(
            "Enter the valid input"
        ))
    }else{
        try{
            const userTodo = await todo.findOneAndUpdate(
                {
                    _id: req.body._id,
                    userId : userId._id
                },
                [
                    {
                        $set: {
                            completed: req.body.completed
                        }
                    }
                ]
            );
            if(todo != null){
                res.status(200).json(jsonGenerate(
                    "Success",
                    {
                        msg : "Task Completed"
                    }
                ))
            }
        }catch(err){
            res.status(400).json(jsonGenerate(
                "Error",
                {
                    error: "ask is not updated !!"
                }
            ))
        }
    }
}

module.exports = markTodo;