const jwt = require("jsonwebtoken");
const jwtPassword = "N@i@t@i@n";

function userAuth (req,res,next) {
    const token = req.headers.authorization;
    return jwt.verify(token,jwtPassword,(err,decoded) =>{
        if(err){
            return res.json({
                error : "Token invalid"
            })
        }
        req.user = decoded;
        return next();
    });
}

module.exports = userAuth;