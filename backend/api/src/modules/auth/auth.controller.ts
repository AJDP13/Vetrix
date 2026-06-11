import AuthService from "./auth.service"
import {Request, Response} from "express";

export default class AuthController {
    authService: AuthService;

    constructor(){
        this.authService = new AuthService();
    }

    register = async (req: Request, res: Response)=>{
        const result = await this.authService.register(req.body);

        return res.status(201).json({
            success:true,
            data:result
        });
    }

    login = async (req: Request, res: Response)=>{

    }

}