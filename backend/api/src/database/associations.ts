import User from "../modules/users/user.model";
import Token from "../modules/auth/token.model";
import Role from "../modules/rbac/role.model";
import UserRole from "../modules/rbac/UserRole.model";
import Permission, {PermissionId} from "../modules/rbac/permission.model";
import RolePermission from "../modules/rbac/RolePermission.model";

export function setupAssociations() {

    //User associations
    User.hasMany(Token, {
        foreignKey: "user_id",
        as: "tokens"
    });
    User.belongsToMany(Role,{
        through: UserRole
    })

    //Token associations
    Token.belongsTo(User, {
        foreignKey: "user_id",
        as: "user"
    });

    //Role associations
    Role.belongsToMany(User,{
        through: UserRole
    })
    Role.belongsToMany(Permission, {
        through: RolePermission
    })

    //Permission Associations
    Permission.belongsToMany(Role, {
        through: RolePermission
    })


}