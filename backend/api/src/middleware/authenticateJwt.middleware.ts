import {Request, Response, NextFunction} from "express";
import ApiError from "../shared/errors/ApiError";
import jwt from "jsonwebtoken";
import { JwtPayload } from "../modules/auth/auth.types";
import env from "../config/env";
import UserService from "../modules/users/user.service";
import User from "../modules/users/user.model";

export async function authenticateJwt(req: Request, res: Response, next: NextFunction) {
    const authHeader = req.headers.authorization;
    if(!authHeader){
        throw new ApiError(401, "Authentication Required")
    }

    const [scheme, token] = authHeader.split(" ");

    if (scheme !== "Bearer" || !token) {
        throw new ApiError(401, "Invalid authorization header");
    }

    try{
        var data = jwt.verify(token, env.jwt.secret) as JwtPayload;
        const user = await User.findByPk(data.sub);
        if(!user) throw new ApiError(401, "JWT User not found");
        if(!user.is_active) throw new ApiError(401, "Your Account is Disabled")
        req.user = data;
    }catch(e){
        throw new ApiError(400, "Invalid JWT");
    }

    next();
}