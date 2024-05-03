const z = require("zod");
const user = require("../models/user")
function validateInput(obj){
    const validateSchema = z.object({
        username: z.string(),
        email: z.string().email(),
        password: z.string()
    });
    const response = validateSchema.safeParse(obj);
    console.log(response);
    return response;
}

const userMiddleware = async(req, res, next) =>{
    //validate if user exists or not 
    const {email, password} = req.body;
    const validateUser = user.findOne({
        email : email,
        password : password
    });
    if(!validateUser){
        res.json({
            msg : "Email or password is invalid"
        });
    }
    else{
        next();
    }
}


module.exports = {validateInput, userMiddleware};