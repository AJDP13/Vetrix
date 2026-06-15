import {PermissionId} from "./permission.model";

export interface CreateRoleDto{
    name: string;
    description: string;
    permissions: PermissionId[];
    priority: bigint;
}