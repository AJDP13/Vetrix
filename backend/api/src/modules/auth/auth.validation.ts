import Joi from "joi";


export const registerSchema = Joi.object({
    username: Joi.string().required(),
    password: Joi.string().min(8).max(128).required(),
    email: Joi.string().email().required(),
    first_name: Joi.string().required(),
    last_name: Joi.string().optional()
})

export const loginSchema = Joi.object({
    username: Joi.string().required(),
    password: Joi.string().required()
});

export const logoutSchema = Joi.object({
    refresh_token: Joi.string().required()
})

export const refreshTokenSchema = Joi.object({
    refresh_token: Joi.string().required()
})