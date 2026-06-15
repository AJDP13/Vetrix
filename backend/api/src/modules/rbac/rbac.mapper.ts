import Role from "./role.model";
import {PermissionResponse, RoleResponse} from "./rbac.types";
import Permission from "./permission.model";

export function buildRoleResponse(role: Role): RoleResponse{
    const data: RoleResponse = {
        id: role.id,
        name: role.name,
        description: role.description,
        permissions: role.permissions ? role.permissions.map(p=>buildPermissionResponse(p)) : [],
        priority: role.priority
    }

    return data;
}

export function buildPermissionResponse(permission: Permission): PermissionResponse{
    return{
        id: permission.id,
        description: permission.description
    }
}