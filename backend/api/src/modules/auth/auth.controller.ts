import AuthService from "./auth.service"
import {Request, Response} from "express";
import TokenService from "./token.service";

export default class AuthController {
    authService: AuthService;
    tokenService: TokenService;

    constructor(){
        this.authService = new AuthService();
        this.tokenService = new TokenService();
    }

    register = async (req: Request, res: Response)=>{
        const result = await this.authService.register(req.body);

        return res.status(201).json({
            success:true,
            data:result
        });
    }

    login = async (req: Request, res: Response)=>{
        const result = await this.authService.login(req.body);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    logout = async(req:Request, res: Response) => {
        await this.authService.logout(req.body);

        return res.status(200).json({
            success:true
        })
    }

    me = async(req: Request, res: Response) => {
        const result = await this.authService.me(req.user!.sub ||"");

        return res.status(200).json({
            success:true,
            data: result
        });
    }

    refresh = async(req: Request, res: Response) => {
        const {refresh_token} = req.body;

        const result = await this.authService.refreshToken(refresh_token);

        return res.status(200).json({
            success:true,
            data: result
        })
    }

}