const {Router} = require("express");
const router = Router();
const validateTask = require("../middlewares/validate_todo");
const userAuth = require("../middlewares/userAuth");
const userTodo = require("../models/todo");
const user = require("../models/user");

router.post("/createtodo",userAuth, async(req,res)=>{
    console.log(req.user._id);
    // try {
        const validate = validateTask.safeParse(req.body);
        if(!validate.success){
            res.json({
                error: "The input is invalid"
            });
        }else{
            // if(!req.user || !req.user.id){
            //     res.status(400).json({
            //         error: "The information is missing"
            //     })
            // }
            // const createTask = await userTodo.create({
            //     title : req.body.title,
            //     description : req.body.description,
            //     completed : req.body.completed,
            //     user : req.user.id
            // })
            // console.log(createTask);
            // res.json(createTask);
        }
    // } catch (error) {
    //     res.json({
    //         error: "The unexpected occured"
    //     });
    // }
});


module.exports = router;

