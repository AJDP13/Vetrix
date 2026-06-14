import User from "./user.model";
import {UserResponse} from "./user.types";
import AuthService from "../auth/auth.service";
import ApiError from "../../shared/errors/ApiError";

export default class UserService {
    private authService: AuthService = new AuthService();

    async getUserById (id: string): Promise<UserResponse>{
        const user = await User.findByPk(id);
        if(!user) throw new ApiError(404, "User ID not found");

        return this.authService.buildUserResponse(user);
    }

    async getUserByUsername (username: string) {
        return User.findOne({
            where:{
                username
            }
        });
    }

    async getAllUsers(): Promise<UserResponse[]>{
        const users = await User.findAll();
        if(users.length == 0) return [];

        return users.map(user=>this.authService.buildUserResponse(user));
    }
}