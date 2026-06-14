import User from "./user.model";
import {UserResponse} from "./user.types";
import AuthService from "../auth/auth.service";

export default class UserService {
    private authService: AuthService = new AuthService();

    async getUserById (id: string){
        return User.findOne({
            where: {id}
        });
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