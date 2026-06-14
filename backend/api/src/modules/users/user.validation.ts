import Joi from "joi";

export const createUserSchema = Joi.object({

})

export const updateMeSchema = Joi.object({
    first_name: Joi.string().optional(),
    last_name: Joi.string().optional(),
    email: Joi.string().email().optional(),
})

export const updateUserSchema = Joi.object({
    first_name: Joi.string().optional(),
    last_name: Joi.string().optional(),
    email: Joi.string().email().optional(),
    password: Joi.string().optional(),
    is_active: Joi.bool().optional()

})

export const changePasswordSchema = Joi.object({
    old_password: Joi.string().required(),
    new_password: Joi.string().required()
});