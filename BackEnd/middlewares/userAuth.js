const jwt = require("jsonwebtoken");
const jsonGenerate = require("../utils/helper");
const StatusCode = require("../utils/constants");

function userAuth (req,res,next) {
    const token = req.headers["auth"];
    if(!token){
        res.json(jsonGenerate(
            StatusCode.INVALID_TOKEN,
            "Access is denied"
        ))
    }
    jwt.verify(token,process.env.ACCESS_TOKEN, (err, decoded)=>{
        if(err){
            res.json(jsonGenerate(
                StatusCode.INVALID_TOKEN,
                err
            ))
        }
        req.user = decoded.userId;
        next();
    })
}

module.exports = userAuth;