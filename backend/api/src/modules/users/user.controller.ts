import {Request, Response} from "express";
import UserService from "./user.service";
import NotFoundError from "../../shared/errors/NotFoundError";
import { IdParam } from "../../shared/types/route.types";
import User from "./user.model";

export default class UserController{
    private userService: UserService = new UserService();

    getUser = async (req: Request, res: Response) => {
        // const {id} = req.params;
        //
        // const user = await this.userService.getUserById(id);
        //
        // if(user == null) throw new NotFoundError ("User not found");
        //
        // return res.json(user)
    }

    updateUser = async (req: Request, res: Response) => {
        const {id} = req.params;
    }

    getAllUsers = async (req: Request, res: Response) => {
        const result = await this.userService.getAllUsers();

        return res.status(200).json({
            success:true,
            data:result
        })
    }
}