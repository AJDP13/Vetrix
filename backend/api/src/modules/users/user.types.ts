export interface UserAttributes {
    id: string;
    username: string;
    email: string;
    password_hash: string;
    is_active: boolean;
}

export interface UserResponseDto {
    id: string;
    username: string;
    email: string;
}