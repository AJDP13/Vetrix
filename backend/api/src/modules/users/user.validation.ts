import Joi from "joi";

export const createUserSchema = Joi.object({

})

export const updateUserSchema = Joi.object({
    user_id: Joi.string().required(),
    first_name: Joi.string().optional(),
    last_name: Joi.string().optional(),
    email: Joi.string().email().optional(),
})

export const changePasswordSchema = Joi.object({
    user_id: Joi.string().required(),
    password: Joi.string().required()
});