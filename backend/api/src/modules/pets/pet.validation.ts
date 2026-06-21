import Joi from "joi";

export const createPetSchema = Joi.object({
    name: Joi.string().required(),
    dob: Joi.date().required(),
    owner_id: Joi.string().required()
})

export const updatePetSchema = Joi.object({
    name: Joi.string().optional(),
    dob: Joi.date().optional()
})