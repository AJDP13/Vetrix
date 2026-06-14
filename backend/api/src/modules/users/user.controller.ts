import {Request, Response} from "express";
import UserService from "./user.service";
import NotFoundError from "../../shared/errors/NotFoundError";
import { IdParam } from "../../shared/types/route.types";
import User from "./user.model";
import {GetUserParams, SearchUsersParams} from "./user.types";

export default class UserController{
    private userService: UserService = new UserService();

    searchUsers = async(req: Request<SearchUsersParams>, res: Response) => {
        return res.status(404).json({

        })
    }

    getUser = async (req: Request<GetUserParams>, res: Response) => {
        const {id} = req.params;

        const user = await this.userService.getUserById(id);

        if(user == null) throw new NotFoundError ("User not found");

        return res.status(200).json({
            success:true,
            data: user
        })
    }

    updateUser = async (req: Request, res: Response) => {
        const {id} = req.params;
    }

    deactivateUser = async(req: Request<GetUserParams>, res:Response) => {
        const {id} = req.params;

        await this.userService.deactivateUser(id);

        return res.status(200).json({
            success:true
        })
    }

    getAllUsers = async (req: Request, res: Response) => {
        const result = await this.userService.getAllUsers();

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    createUser = async(req: Request, res: Response) => {
        const result = await this.userService.createUser(req.body)

        return res.status(201).json({
            success:true,
            data:result
        })
    }
}