const Router = require("express");
const authMiddleware = require("../middlewares/user")
const router = Router();
const registerUser = require("../controllers/registerController");
const loginUser = require("../controllers/loginUserController");

router.post("/register",registerUser);
router.post("/login",authMiddleware, loginUser);

module.exports = router;

