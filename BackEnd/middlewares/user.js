const user = require("../models/user");
const jsonGenerate = require("../utils/helper");

const authMiddleware = async(req, res, next) =>{
    //validate if user exists or not 
    const {email, password} = req.body;
    const validateUser = await user.findOne({
        email : email})
    console.log(validateUser.password);
    if(!validateUser){
        res.status(404).json(jsonGenerate(
            "error",
            {
                error : "User doesn't exists" 
            }
        ))
    }
    if(validateUser.password == password){
        next();
    }else{
        res.status(401).json(jsonGenerate(
            "error",
            {
                error: "Incorrect Password"
            }
        ))
    }
}


module.exports = authMiddleware;