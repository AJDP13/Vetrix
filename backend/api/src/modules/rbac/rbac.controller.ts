import {Request, Response} from "express";
import RBACService from "./rbac.service";
import {CreateRoleDto, RoleResponse, UpdateRoleDto} from "./rbac.types";
import ApiError from "../../shared/errors/ApiError";

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

    getRole = async(req: Request, res: Response) => {
        const roleId:string = req.params.roleId as string ?? null;

        if(!roleId) throw new ApiError(400, "Missing parameter RoleID");

        const result = await this.rbacService.getRole(roleId);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    editRole = async (req: Request, res: Response) => {
        const roleId: string = req.params.roleId as string ?? null;

        if(!roleId) throw new ApiError(400, "Missing Role ID Parameter");

        const data: UpdateRoleDto = {
            role_id: roleId,
            ...req.body
        }

        const result: RoleResponse = await this.rbacService.updateRole(data);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    deleteRole = async (req: Request, res: Response) => {
        const roleId: string = req.params.roleId as string ?? null;

        if(!roleId) throw new ApiError(400, "Missing Role ID Parameter");

        await this.rbacService.deleteRole(roleId);

        return res.status(200).json({
            success:true
        })
    }

}