const jwt = require("jsonwebtoken");
const user = require("../models/user");
const jsonGenerate= require("../utils/helper");
const StatusCode = require("../utils/constants");

const loginUser = async(req,res) =>{
    const userId = await user.findOne(req.body);
    var token = jwt.sign({userId: userId._id}, process.env.ACCESS_TOKEN);
    res.json(jsonGenerate(
        StatusCode.SUCCESS,
        "Login Successfully !!",
        {
            userId: userId._id,
            token: token
        }
    ));
}

module.exports = loginUser;