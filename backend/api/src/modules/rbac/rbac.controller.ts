import {Request, Response} from "express";
import RBACService from "./rbac.service";
import {CreateRoleDto, RoleResponse} from "./rbac.types";

export default class RBACController {
    rbacService: RBACService = new RBACService();

    createRole = async(req: Request, res: Response) =>{
        const data: CreateRoleDto = req.body;

        const result = await this.rbacService.createRole(data);

        return res.status(201).json({
            success:true,
            data:result
        })
    }

    viewRoles = async(req: Request, res: Response) => {
        const result: RoleResponse[] = await this.rbacService.getRoles();

        return res.status(200).json({
            success:true,
            data: result
        })
    }

}