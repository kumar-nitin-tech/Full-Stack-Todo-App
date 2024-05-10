const z = require("zod");

const validateUserSchema = z.object({
    username: z.string(),
    email: z.string().email(),
    password: z.string()
});

module.exports = validateUserSchema;