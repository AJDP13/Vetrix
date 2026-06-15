import {PermissionId} from "./permission.model";

export interface PermissionResponse{
    id: string;
    description: string;
}

export interface CreateRoleDto{
    name: string;
    description: string;
    permissions: PermissionId[];
    priority: bigint;
}

export interface RoleResponse{
    id: string;
    name: string;
    description: string;
    permissions: PermissionResponse[];
    priority: bigint;
}

export interface UpdateRoleDto{
    role_id: string;

    name?: string;
    description?: string;
    permissions?: PermissionId[],
    priority?: bigint
}