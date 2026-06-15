import {CreateRoleDto} from "./rbac.types";
import Role from "./role.model";
import sequelize from "../../config/database";
import Permission from "./permission.model";
import ApiError from "../../shared/errors/ApiError";
import {buildRoleResponse} from "./rbac.mapper";

export default class RBACService{
    async createRole(data: CreateRoleDto){
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
            await transaction.rollback();
            console.error(err)
            throw new ApiError(500, "Server error when creating role");
        }


    }
}