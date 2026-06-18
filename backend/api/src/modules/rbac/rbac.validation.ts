import Joi from "joi";
import {PermissionId} from "./permission.model";


export const createRoleSchema = Joi.object({
    name: Joi.string().required(),
    description: Joi.string().required(),
    permissions: Joi.array().items(Joi.string().valid(...Object.values(PermissionId))).unique().required(),
    priority: Joi.number().positive().required()
})

export const updateRoleSchema = Joi.object({
    name: Joi.string().optional(),
    description: Joi.string().optional(),
    permissions: Joi.array().items(Joi.string().valid(...Object.values(PermissionId))).unique().optional(),
    priority: Joi.number().positive().optional()
})

export const updateUserRolesSchema = Joi.object({
    roles: Joi.array().items(Joi.string().valid(...Object.values(Permissions))).unique().required()
})