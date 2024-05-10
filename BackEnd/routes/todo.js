const {Router} = require("express");
const router = Router();
const userAuth = require("../middlewares/userAuth");
const createTodo = require("../controllers/createTodoController");
const markTodo = require("../controllers/markTodoController");
const deleteTodo = require("../controllers/deleteTodoController");
const getAllTodos = require("../controllers/getAllTodosController");

router.post("/createtodo",userAuth, createTodo);
router.post("/marktodo",userAuth,markTodo);
router.post("/deletetodo",userAuth,deleteTodo);
router.get("/allTodo",userAuth,getAllTodos);

module.exports = router;

