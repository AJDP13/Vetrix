import Permission, {PermissionId} from "./permission.model";
import Role from "./role.model";
import User from "../users/user.model";
import bcrypt from "bcrypt"
import sequelize from "../../config/database";

export async function seedPermissions() {
    const transaction = await sequelize.transaction();
    const permissions = Object.values(PermissionId);

    for (const permission of permissions) {
        await Permission.findOrCreate({
            where: {
                id: permission,
            },
            transaction
        });
    }

    //Default SysAdmin role
    const [role, created] = await Role.findOrCreate({
        where:{
            name: "System Administrator",
            priority: 1,
            description: "The Default role for the initial user"
        },
        transaction
    });

    if(created) await role.setPermissions(permissions);

    //Default SysAdmin User
    const [sysAdmin, sysAdminCreated]: [User, boolean] = await User.findOrCreate({
        where:{
            username: "administrator",
            first_name: "System Administrator",
            email: "admin@aerotrixlabs.com",
            password_hash: await bcrypt.hash("admin", 10)
        },
        transaction
    })

    await transaction.commit();
}