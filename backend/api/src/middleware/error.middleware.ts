import { Request, Response, NextFunction } from "express";

import ApiError from "../shared/errors/ApiError";

export function errorHandler(
    err: Error,
    req: Request,
    res: Response,
    next: NextFunction
){
    console.error(err);

    if(err instanceof ApiError){
        return res.status(
            err.statusCode
        ).json({
            succes:false,
            status_code:err.statusCode,
            message: err.message
        });
    }

    return res.status(500).json({
        success:false,
        status_code: 500,
        message: "Internal Server Error"
    });
}