export interface RegisterDto {
    username: string;
    email: string;
    password: string;
    first_name: string;
    last_name?: string;
}

export interface LoginDto {
    username: string;
    password: string;
}

export interface LoginResponse {
    access_token: string;
    refresh_token: string;
    user: MeResponse
}

export interface LogoutDto{
    refresh_token: string;
}

export interface JwtPayload {
    sub: string;
    username: string;
}

export interface MeResponse{
    id:string;
    username: string;
    email: string;
    first_name: string;
    last_name: string;
}