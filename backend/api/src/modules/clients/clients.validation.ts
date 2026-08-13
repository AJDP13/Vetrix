import Joi from "joi";

export const createClientSchema = Joi.object({
    first_name: Joi.string().required(),
    last_name: Joi.string().required(),
    email: Joi.string().email().required(),
    phone: Joi.string().required()
})

export const updateClientSchema = Joi.object({
    first_name: Joi.string().optional().allow(''),
    last_name: Joi.string().optional().allow(''),
    email: Joi.string().optional(),
    phone: Joi.string().optional().allow(''),
    address_line_1: Joi.string().optional().allow(''),
    address_line_2: Joi.string().optional().allow(''),
    address_line_3: Joi.string().optional().allow(''),
    address_city: Joi.string().optional().allow(''),
    address_postcode: Joi.string().optional().allow('')
})