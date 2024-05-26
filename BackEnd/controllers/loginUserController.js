const jwt = require("jsonwebtoken");
const user = require("../models/user");
const jsonGenerate= require("../utils/helper");

const loginUser = async(req,res) =>{
    const userId = await user.findOne(req.body);
    console.log(userId);
    var token = jwt.sign({userId: userId.email}, process.env.ACCESS_TOKEN);
    res.status(200).json(jsonGenerate(
        "Login Successfully !!",
        {
            userId: userId._id,
            token: token
        }
    ));
}

module.exports = loginUser;