import authService from "./auth.service"
import {Request, Response} from "express";

export default class AuthController {
    async register(req: Request, res: Response) {
        const result = await authService.register(req.body);
    }

    async login(req: Request, res: Response){

    }

}