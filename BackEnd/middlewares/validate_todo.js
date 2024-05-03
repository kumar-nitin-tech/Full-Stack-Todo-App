const z = require("zod");
const user = require("../models/user");

const validateTask = z.object({
    title : z.string(),
    description : z.string(),
    completed : z.boolean()
});

module.exports = validateTask;