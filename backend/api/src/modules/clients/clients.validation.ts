import Joi from "joi";

export const createClientSchema = Joi.object({
    first_name: Joi.string().required(),
    last_name: Joi.string().required(),
    email: Joi.string().email().required(),
    phone: Joi.string().required()
})

export const updateClientSchema = Joi.object({
    first_name: Joi.string().optional(),
    last_name: Joi.string().optional(),
    email: Joi.string().optional(),
    phone: Joi.string().optional(),
    address_line_1: Joi.string().optional(),
    address_line_2: Joi.string().optional(),
    address_line_3: Joi.string().optional(),
    address_city: Joi.string().optional(),
    address_postcode: Joi.string().optional()
})