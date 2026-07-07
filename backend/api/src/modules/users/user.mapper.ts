import { buildPermissionResponse, buildRoleResponse } from "../rbac/rbac.mapper";
import User from "./user.model";
import {UserResponse} from "./user.types";
import { PermissionResponse } from "../rbac/rbac.types";

export function buildUserResponse(user: User): UserResponse{
    const permissions: Set<PermissionResponse> = new Set()

    if(user.roles){
        for(const role of user.roles){
            if(role.permissions){
                for(const permission of role.permissions){
                    permissions.add(buildPermissionResponse(permission))
                }
            }
        }   
    }

    return {
        id: user.id,
        username: user.username,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name ?? "",
        is_active: user.is_active,
        roles: (user.roles ? user.roles?.map(buildRoleResponse) : []),
        permissions: Array.from(permissions)
    };
}