import bcrypt from "bcrypt";
import jwt, { JwtPayload } from "jsonwebtoken";

import User from "../users/user.model";
import env from "../../config/env";

import { LoginDto, LoginResponse, RegisterDto, RegisterResponse } from "./auth.types";
import ApiError from "../../shared/errors/ApiError";

export default class AuthService {
    async register(data: RegisterDto): Promise<RegisterResponse>{
        const existingUsername = await User.findOne({
            where: { username: data.username }
        });

        if (existingUsername) {
            throw new ApiError(409, "Username already exists");
        }

        // Check email
        const existingEmail = await User.findOne({
            where: { email: data.email }
        });

        if (existingEmail) {
            throw new ApiError(409, "Email already exists");
        }

        const password_hash = await bcrypt.hash(data.password, 10);

        const user = await User.create({
            username: data.username,
            first_name: data.first_name,
            last_name: data.last_name || "",
            email: data.email,
            password_hash
        });

        return {
            id: user.id,
            username: user.username,
            email: user.email
        }
    }

    async login(data: LoginDto): Promise<LoginResponse>{
        const user = await User.findOne({
            where:{
                username: data.username
            }
        });

        if(!user){
            throw new ApiError(401, "Invalid Username or Password");
        }

        const pw_verify = await bcrypt.compare(data.password, user.password_hash);

        if(!pw_verify){
            throw new ApiError(401, "Invalid Username or Password")
        }

        const iat = new Date().getTime()
        const exp = iat + env.jwt.expiry;

        const payload: JwtPayload = {
            sub: user.id,
            username: user.username,
            first_name: user.first_name,
            last_name: user.last_name || null,
            email: user.email
        }

        const signed = jwt.sign(
    payload,
    env.jwt.secret,
    {
        expiresIn: env.jwt.expiry
    }
);

        return {
            access_token: signed,
            refresh_token: "",//To be done
            user:{
                id: user.id,
                username: user.username,
                email: user.email,
                first_name: user.first_name,
                last_name: user.last_name || ""
            }
        }
    }
}