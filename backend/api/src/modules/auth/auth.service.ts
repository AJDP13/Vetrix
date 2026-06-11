import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

import User from "../users/user.model";
import env from "../../config/env";

import { LoginDto, RegisterDto, RegisterResponse } from "./auth.types";
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
            email: data.email,
            password_hash
        });

        return {
            id: user.id,
            username: user.username,
            email: user.email
        }
    }
}