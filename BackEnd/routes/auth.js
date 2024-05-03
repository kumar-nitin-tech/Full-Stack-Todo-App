const {Router} = require("express");
const z = require("zod");
const {validateInput} = require("../middlewares/user");
const {userMiddleware} = require("../middlewares/user")
const user = require("../models/user")
const router = Router();
const jwt = require("jsonwebtoken");
const jwtPassword = "N@i@t@i@n";

router.post("/signup", async(req,res)=>{
    const response = validateInput(req.body);
    if(!response.success){
        res.json({
            msg : "User Input is invalid"
        });
    } 
    const userExist = await user.findOne({email : req.body.email});
    if(userExist){
        return res.json({
            error : "User already exits"
        });
    }
    await user.create({
        username : response.data.username,
        email : response.data.email,
        password : response.data.password
    });

    res.json({
        msg : "User is created"
    });
});

router.post("/signin",userMiddleware, (req, res)=>{
    const email = req.body.email;
    var token = jwt.sign({email : email}, jwtPassword);
    res.json({
        token
    });
});

module.exports = router;

