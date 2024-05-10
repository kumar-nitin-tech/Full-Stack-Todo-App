const  z  = require("zod");
const todo = require("../models/todo");
const user = require("../models/user");
const StatusCode = require("../utils/constants");
const jsonGenerate = require("../utils/helper");

//We take todo id to find the todo in user id 
const markTodo = async(req, res)=>{
    const userId = await user.findOne({email: req.user});
    const booleanSchema = z.boolean();
    const validate = booleanSchema.safeParse(req.body.completed);
    if(!validate.success){
        return res.json(jsonGenerate(
            StatusCode.VALIDATION_ERROR,
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
                res.json(jsonGenerate(
                    StatusCode.SUCCESS,
                    "Task Completed"
                ))
            }
        }catch(err){
            res.json(jsonGenerate(
                StatusCode.UNPROCESSABLE_ENTITY,
                "Task is not updated !!",
                null
            ))
        }
    }
}

module.exports = markTodo;