import User from "./user.model";
import {UserResponse} from "./user.types";
import AuthService from "../auth/auth.service";
import ApiError from "../../shared/errors/ApiError";
import {RegisterDto} from "../auth/auth.types";
import bcrypt from "bcrypt";

export default class UserService {
    private authService: AuthService = new AuthService();

    async getUserById (id: string): Promise<UserResponse | null>{
        const user = await User.findByPk(id);
        if(!user) return null

        return this.authService.buildUserResponse(user);
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
        user.save();
        return;
    }

    async getAllUsers(): Promise<UserResponse[]>{
        const users = await User.findAll();
        if(users.length == 0) return [];

        return users.map(user=>this.authService.buildUserResponse(user));
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

        return this.authService.buildUserResponse(user);
    }
}