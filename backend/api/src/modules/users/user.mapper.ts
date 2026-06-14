import User from "./user.model";
import {UserResponse} from "./user.types";

export function buildUserResponse(user: User): UserResponse{
    return {
        id: user.id,
        username: user.username,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name ?? "",
        is_active: user.is_active
    };
}