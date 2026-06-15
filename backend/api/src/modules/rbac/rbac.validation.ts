import Joi from "joi";
import {PermissionId} from "./permission.model";


export const createRoleSchema = Joi.object({
    name: Joi.string().required(),
    description: Joi.string().required(),
    permissions: Joi.array().items(Joi.string().valid(...Object.values(PermissionId))).required(),
    priority: Joi.number().positive().required()
})