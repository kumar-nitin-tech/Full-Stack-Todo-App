const jwt = require("jsonwebtoken");
const validateUserSchema = require("../validateSchemas/userSchema");
const user = require("../models/user");
const jsonGenerate = require("../utils/helper");

const registerUser = async(req,res)=>{
    const response = validateUserSchema.safeParse(req.body);
    if(!response.success){
        return res.status(400).json(jsonGenerate(
            "Input is invalid",
            {
                error: "Enter a valid input"
            }
        ))
    } 
    const userExist = await user.findOne({email : req.body.email});
    if(userExist){
        return res.status(409).json(jsonGenerate(
            "Error",
            {
                error: "User already exists"
            }
        ));
    }
    const result = await user.create({
        username : req.body.username,
        email : req.body.email,
        password : req.body.password
    });
    const token = jwt.sign({userId : result.email}, process.env.ACCESS_TOKEN);
    return res.status(200).json(jsonGenerate(
        "Registered Successfully",
        {
            userId: result._id,
            token: token
        } 
    ));
}

module.exports = registerUser;