import { PermissionResponse, RoleResponse } from "../rbac/rbac.types";

export interface UserResponse {
    id:string;
    username: string;
    email: string;
    first_name: string;
    last_name: string;
    is_active: boolean;
    roles: RoleResponse[]
    permissions: PermissionResponse[]
}

export interface SearchUsersParams{
    id?: string;
    username?: string;
    first_name?: string;
    last_name?: string;
    email?: string;
}

export interface UpdateMeDto{
    id: string;

    first_name?: string;
    last_name?: string;
    email?: string;
}

export interface UpdateUserDto extends UpdateMeDto{
    //Additional options that normal users cannot just plainly update without verification
    password?: string;

    is_active?: boolean
}

export interface ChangePasswordDto{
    id: string;
    old_password:string;
    new_password:string;
}