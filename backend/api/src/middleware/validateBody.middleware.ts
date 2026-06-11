import {Request, Response, NextFunction} from "express";
import Joi from "joi";
import ApiError from "../shared/errors/ApiError";

export function validateBody(schema: Joi.ObjectSchema) {
    return (req: Request, res: Response, next: NextFunction) => {
        if (!req.body) {
            throw new ApiError(
                400,
                "Request body is required"
            );
        }

        const { error, value } = schema.validate(req.body, {
            abortEarly: false,
            stripUnknown: true
        });

        if (error) {
            throw new ApiError(
                400,
                error.details.map(d => d.message).join(", ")
            )
        }

        req.body = value;

        next();
    };
}