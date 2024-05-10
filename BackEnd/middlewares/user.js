const user = require("../models/user");
const StatusCode = require("../utils/constants");
const jsonGenerate = require("../utils/helper");

const authMiddleware = (req, res, next) =>{
    //validate if user exists or not 
    const {email, password} = req.body;
    const validateUser = user.findOne({
        email : email,
        password : password
    });
    if(!validateUser){
        res.json(jsonGenerate(
            StatusCode.AUTH_ERROR,
            "Invalid User",
        ))
    }
    else{
        next();
    }
}


module.exports = authMiddleware;