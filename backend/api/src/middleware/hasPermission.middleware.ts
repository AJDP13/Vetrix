import {Request, Response, NextFunction, RequestHandler} from "express";
import ApiError from "../shared/errors/ApiError";
import Permission, {PermissionId} from "../modules/rbac/permission.model";
import UserRole from "../modules/rbac/UserRole.model";
import Role from "../modules/rbac/role.model";
import User from "../modules/users/user.model";

export function hasPermission(permission_id: PermissionId) {
    return async (req: Request, res: Response, next: NextFunction) => {
        if (req.user == null) {
            throw new ApiError(
                401,
                "JWT is required"
            );
        }

        const permission = await Permission.findOne({
            where: {
                id: permission_id
            },
            include: [{
                model: Role,
                as: "roles",
                required: true,
                include: [{
                    model: User,
                    as: "users",
                    where: {
                        id: req.user!.sub
                    },
                    required: true
                }]
            }]
        });

        const hasPermission = !!permission;

        if(!hasPermission) throw new ApiError(401, "User doesn't have required role");

        next();
    };
}