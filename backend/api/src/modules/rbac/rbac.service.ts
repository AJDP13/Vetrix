import {CreateRoleDto, PermissionResponse, RoleResponse, UpdateRoleDto, UpdateUserRolesDto} from "./rbac.types";
import Role from "./role.model";
import sequelize from "../../config/database";
import Permission from "./permission.model";
import ApiError from "../../shared/errors/ApiError";
import {buildPermissionResponse, buildRoleResponse} from "./rbac.mapper";
import UserRole from "./UserRole.model";
import User from "../users/user.model";

export default class RBACService{
    async createRole(data: CreateRoleDto){
        const name_exists = await Role.findOne({
            where:{
                name: data.name
            }
        });

        if(name_exists) throw new ApiError(409, "Role name already exists");

        const transaction = await sequelize.transaction();

        try{
            const role = await Role.create({
                name: data.name,
                description: data.description,
                priority: data.priority
            }, {transaction})

            const permissions = await Permission.findAll({
                where:{
                    id: data.permissions
                },
                transaction
            })

            if(permissions.length != data.permissions.length) throw new ApiError(400, "One or more permissions invalid");

            await role.setPermissions(permissions, {transaction});

            await role.reload({
                include: [{
                    model: Permission,
                    as: "permissions"
                }],
                transaction
            });

            await transaction.commit()

            return buildRoleResponse(role);
        }catch(err){
            try{
                await transaction.rollback();
            }catch(e){}
            throw err;
        }
    }

    async getRoles(): Promise<RoleResponse[]>{
        const roles = await Role.findAll({
            include:{
                model: Permission,
                as: "permissions"
            }
        });

        return roles.map(r=>buildRoleResponse(r));
    }

    async getRole(id: string): Promise<RoleResponse>{
        const role = await Role.scope("withPermissions").findByPk(id);

        if(!role) throw new ApiError(404, "Role not found");

        return buildRoleResponse(role);
    }

    async updateRole(data: UpdateRoleDto): Promise<RoleResponse>{
        const name_exists = await Role.findOne({
            where:{
                name: data.name
            }
        });

        if(name_exists) throw new ApiError(409, "Role name already exists");

        const transaction = await sequelize.transaction();

        try{
            const role = await Role.scope("withPermissions").findByPk(data.role_id, {transaction});

            if(!role) throw new ApiError(404, "Role not found");

            if(data.name) role.name = data.name
            if(data.description) role.description = data.description
            if(data.priority !== undefined) role.priority = data.priority;
            if(data.permissions){
                const permissions = await Permission.findAll({
                    where:{
                        id: data.permissions
                    },
                    transaction
                })
                if(permissions.length != data.permissions.length) throw new ApiError(400, "One or more permissions were invalid");
                await role.setPermissions(permissions, {transaction});
            }

            await role.save({transaction});

            await role.reload({transaction});

            await transaction.commit();

            return buildRoleResponse(role);
        }catch(err){
            try{
                await transaction.rollback();
            }catch(e2){}
            throw err;
        }
    }

    async deleteRole(role_id: string): Promise<void>{
        const role = await Role.findByPk(role_id);

        if(!role) throw new ApiError(404, "Role ID not found");

        const userCount = await UserRole.count({
            where: {
                role_id: role.id
            }
        });

        if(userCount != 0) throw new ApiError(400, "Role is assigned to users");

        await role.destroy();

        return;
    }

    async getUserPermissions(user_id: string): Promise<PermissionResponse[]>{
        const permissions = await Permission.findAll({
            include: [{
                model: Role,
                as: "roles",
                required: true,
                include: [{
                    model: User,
                    as: "users",
                    where: {
                        id: user_id
                    },
                    required: true
                }]
            }]
        });

        return permissions.map(buildPermissionResponse);
    }

    async getUserRoles(id: string): Promise<RoleResponse[]>{
        const user = await User.findByPk(id, {
            include: [{
                model: Role,
                as: "roles",
                include: [{
                    model: Permission,
                    as: "permissions"
                }]
            }]
        });

        if (!user) {
            throw new ApiError(404, "User not found");
        }

        return (user?.roles || []).map(r=>buildRoleResponse(r));
    }

    async updateUserRoles(data: UpdateUserRolesDto): Promise<RoleResponse[]>{
        const uniqueRoles = new Set(data.roles);

        if (uniqueRoles.size !== data.roles.length) {
            throw new ApiError(400,"Duplicate roles supplied");
        }

        const user = await User.findByPk(data.user_id);

        if (!user) {
            throw new ApiError(404, "User not found");
        }

        const roles = await Role.findAll({
            where: {
                id: data.roles
            }
        });

        if (roles.length !== data.roles.length) {
            throw new ApiError(400,"One or more roles are invalid");
        }

        await user.setRoles(roles);

        const updatedUser = await User.findByPk(data.user_id, {
            include: [{
                model: Role,
                as: "roles",
                include: [{
                    model: Permission,
                    as: "permissions"
                }]
            }]
        });

        return updatedUser?.roles?.map(buildRoleResponse) ?? [];
    }
}