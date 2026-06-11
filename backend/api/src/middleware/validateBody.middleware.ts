import {Request, Response, NextFunction} from "express";
import Joi from "joi";

export function validateBody(schema: Joi.ObjectSchema) {
    return (req: Request, res: Response, next: NextFunction) => {

        const { error, value } = schema.validate(req.body, {
            abortEarly: false,
            stripUnknown: true
        });

        if (error) {
            return res.status(400).json({
                success: false,
                status_code: 400,
                message: "Validation failed",
                errors: error.details.map(d => ({
                    field: d.path.join("."),
                    message: d.message
                }))
            });
        }

        req.body = value;

        next();
    };
}