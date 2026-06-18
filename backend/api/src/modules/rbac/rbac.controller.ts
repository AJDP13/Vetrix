import {Request, Response} from "express";
import RBACService from "./rbac.service";
import {CreateRoleDto, PermissionResponse, RoleResponse, UpdateRoleDto, UpdateUserRolesDto} from "./rbac.types";
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

    getUserPermissions = async(req:Request, res: Response) => {
        const id: string = req.params.id as string;
        const result: PermissionResponse[] = await this.rbacService.getUserPermissions(id);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    getUserRoles = async(req: Request, res: Response) => {
        const id:string = req.params.id as string;
        const result: RoleResponse[] = await this.rbacService.getUserRoles(id);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    updateUserRoles = async(req: Request, res: Response) => {
        const id:string = req.params.id as string;
        const roles: string[] = req.body.roles;

        const data: UpdateUserRolesDto = {
            user_id: id,
            roles
        }

        const result: RoleResponse[] = await this.rbacService.updateUserRoles(data);

        return res.status(200).json({
            success:true,
            data: result
        })
    }
}