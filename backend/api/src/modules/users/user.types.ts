export interface UserAttributes {
    id: string;
    username: string;
    email: string;
    password_hash: string;
    is_active: boolean;
}

export interface UserResponse {
    id:string;
    username: string;
    email: string;
    first_name: string;
    last_name: string;
}

export interface GetUserParams{
    id: string;
}

export interface CreateUserDto{

}

export interface UpdateUserDto{

}

export interface ChangePasswordDto{

}

export interface UserListResponse{

}