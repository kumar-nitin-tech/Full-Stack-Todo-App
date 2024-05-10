const z = require("zod");
const validateTask = z.object({
    title : z.string(),
    description : z.string(),
    completed : z.boolean()
});

module.exports = validateTask;