import bcrypt from "bcrypt";
import jwt, { JwtPayload } from "jsonwebtoken";

import User from "../users/user.model";
import env from "../../config/env";

import { LoginDto, LoginResponse, LogoutDto, RegisterDto } from "./auth.types";
import {UserResponse} from "../users/user.types";
import ApiError from "../../shared/errors/ApiError";
import TokenService from "./token.service";
import Token, { TokenType } from "./token.model";
import {buildUserResponse} from "../users/user.mapper";

export default class AuthService {
    private tokenService: TokenService = new TokenService();

    private generateAccessToken(user: User): string{
        const payload: JwtPayload = {
            sub:user.id,
            username: user.username
        }
        return jwt.sign(payload, env.jwt.secret, {
            expiresIn: env.jwt.expiry
        })
    }

    private buildLoginResponse(user: User, access_token: string, refresh_token: string): LoginResponse{
        return {
            access_token,
            refresh_token,
            user: buildUserResponse(user)
        }
    }

    async register(data: RegisterDto): Promise<UserResponse>{
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

        return buildUserResponse(user);
    }

    async login(data: LoginDto): Promise<LoginResponse>{
        const user = await User.scope("withRolesAndPermissions").findOne({
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

        if(!user.is_active) throw new ApiError(401, "User has been deactivated");

        const signed = this.generateAccessToken(user);
        const refresh_token = await this.tokenService.createToken(user.id, TokenType.REFRESH);

        return this.buildLoginResponse(user, signed, refresh_token);
    }

    async logout(data: LogoutDto): Promise<void>{
        const [tokenId, tokenSecret] = data.refresh_token.split(".");

        if(!tokenId || !tokenSecret) return;

        const token = await this.tokenService.validateToken(tokenId, tokenSecret, TokenType.REFRESH);

        if(token) await this.tokenService.revokeToken(token);

        return;
    }

    async me(id: string): Promise<UserResponse>{
        const user = await User.scope("withRolesAndPermissions").findByPk(id);

        if(!user) throw new ApiError(404, "User not found");

        return buildUserResponse(user);
    }

    async refreshToken(token_str: string): Promise<LoginResponse>{
        const [tokenId, tokenSecret] = token_str.split(".");

        if(!tokenId || !tokenSecret) throw new ApiError(401, "Refresh token invalid");

        const token = await this.tokenService.validateToken(tokenId, tokenSecret, TokenType.REFRESH);

        if(!token) throw new ApiError(401, "Refresh Token Unauthorised");

        const user = await User.findByPk(token.user_id);
        if(!user) throw new ApiError(401, "Invalid refresh token");
        if(!user.is_active) throw new ApiError(401, "User Account Disabled");

        await this.tokenService.revokeToken(token);

        //Generate new token and return to user in LoginResponse format
        const refresh_token = await this.tokenService.createToken(user.id, TokenType.REFRESH);
        const access_token: string = this.generateAccessToken(user);

        return this.buildLoginResponse(user, access_token, refresh_token);
    }
}