import {Request, Response} from "express";
import UserService from "./user.service";
import NotFoundError from "../../shared/errors/NotFoundError";
import {ChangePasswordDto, SearchUsersParams, UpdateMeDto, UpdateUserDto} from "./user.types";

export default class UserController{
    private userService: UserService = new UserService();

    searchUsers = async(req: Request<SearchUsersParams>, res: Response) => {
        return res.status(404).json({

        })
    }

    getUser = async (req: Request, res: Response) => {
        const id = req.params.id as string;

        const user = await this.userService.getUserById(id);

        if(user == null) throw new NotFoundError ("User not found");

        return res.status(200).json({
            success:true,
            data: user
        })
    }

    patchMe = async(req: Request, res: Response) => {
        const data: UpdateMeDto = {
            id: req.user!.sub as string,
            ...req.body,
        }

        const result = await this.userService.updateMe(data);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    updateUser = async (req: Request, res: Response) => {
        const id = req.params.id;

        const data: UpdateUserDto = {
            id,
            ...req.body
        }

        const result = await this.userService.updateUser(data);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    deactivateUser = async(req: Request, res:Response) => {
        const id = req.params.id as string;

        await this.userService.deactivateUser(id);

        return res.status(200).json({
            success:true
        })
    }

    changePassword = async(req: Request, res: Response) => {
        const id:string = req.user!.sub ?? "";
        const{new_password, old_password} = req.body;

        console.log("PW UserID: " + id);

        const data: ChangePasswordDto = {
            id,
            old_password,
            new_password
        }

        await this.userService.changePassword(data)

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