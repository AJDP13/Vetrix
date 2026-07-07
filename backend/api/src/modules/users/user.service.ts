import User from "./user.model";
import {ChangePasswordDto, UpdateMeDto, UpdateUserDto, UserResponse} from "./user.types";
import ApiError from "../../shared/errors/ApiError";
import {RegisterDto} from "../auth/auth.types";
import bcrypt from "bcrypt";
import TokenService from "../auth/token.service";
import {TokenType} from "../auth/token.model";
import {buildUserResponse} from "./user.mapper";

export default class UserService {
    private tokenService: TokenService = new TokenService();

    async getUserById (id: string): Promise<UserResponse | null>{
        const user = await User.scope("withRoles").findByPk(id);
        if(!user) return null

        return buildUserResponse(user);
    }

    async getUserByUsername (username: string) {
        return User.findOne({
            where:{
                username
            }
        });
    }

    async deactivateUser(id: string): Promise<void>{
        const user = await User.findByPk(id);
        if(!user) throw new ApiError(404, "User ID not found");

        user.is_active = false;
        await user.save();
        return;
    }

    async getAllUsers(): Promise<UserResponse[]>{
        const users = await User.findAll();
        if(users.length == 0) return [];

        return users.map(user=>buildUserResponse(user));
    }

    async createUser(data: RegisterDto): Promise<UserResponse | null>{
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

    async changePassword(data: ChangePasswordDto): Promise<void>{
        const user = await User.findByPk(data.id);
        if(!user) throw new ApiError(404, "User not found")

        const old_password_valid = await bcrypt.compare(data.old_password, user.password_hash);
        if(!old_password_valid) throw new ApiError(400, "Old password incorrect");

        const new_password_same = await bcrypt.compare(data.new_password, user.password_hash);
        if(new_password_same) throw new ApiError(401, "New password cannot be the same as the old one")

        //Revoke all previous refresh tokens
        await this.tokenService.revokeAllUserTokens(user.id, TokenType.REFRESH);

        const new_hash = await bcrypt.hash(data.new_password, 10);
        user.password_hash = new_hash;
        await user.save();

        return;
    }

    private async updateUserInternal(data: UpdateUserDto): Promise<UserResponse>{
        const user = await User.findByPk(data.id);
        if(!user) throw new ApiError(404, "User not Found");

        if(data.first_name) user.first_name = data.first_name;
        if(data.last_name) user.last_name = data.last_name;
        if(data.email){
            //Check if email already in use
            const found = await User.findOne({
                where:{
                    email: data.email
                }
            })
            if(found && found.id!==user.id) throw new ApiError(400, "Email already in use by another user");
            user.email = data.email;
        }
        if(data.password) user.password_hash = await bcrypt.hash(data.password, 10);
        if(data.is_active != null) user.is_active = data.is_active

        await user.save();
        return buildUserResponse(user);
    }

    async updateMe(data: UpdateMeDto): Promise<UserResponse>{
        return this.updateUserInternal(data);
    }

    async updateUser(data: UpdateUserDto): Promise<UserResponse>{
        return this.updateUserInternal(data);
    }
}