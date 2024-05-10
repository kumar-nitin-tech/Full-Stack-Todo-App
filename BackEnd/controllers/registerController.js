const jwt = require("jsonwebtoken");
const validateUserSchema = require("../validateSchemas/userSchema");
const user = require("../models/user");
const jsonGenerate = require("../utils/helper");
const StatusCode = require("../utils/constants");

const registerUser = async(req,res)=>{
    const response = validateUserSchema.safeParse(req.body);
    if(!response.success){
        res.json(jsonGenerate(
            StatusCode.VALIDATION_ERROR,
            "Input is invalid",
            {
                error: "Enter a valid input"
            }
        ))
    } 
    const userExist = await user.findOne({email : req.body.email});
    if(userExist){
        return res.json({
            error : "User already exits"
        });
    }
    const result = await user.create({
        username : req.body.username,
        email : req.body.email,
        password : req.body.password
    });
    const token = jwt.sign({userId : result.email}, process.env.ACCESS_TOKEN)
    res.json(jsonGenerate(
        StatusCode.SUCCESS,
        "Registered Successfully",
        {
            userId: result._id,
            token: token
        } 
    ));
}

module.exports = registerUser;