import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

import User from "../users/user.model";
import env from "../../config/env";

import { LoginDto, RegisterDto } from "./auth.types";




class AuthService {

    async login(data: LoginDto){
        
    }

    async register(data: RegisterDto){
    }
}

export default new AuthService()