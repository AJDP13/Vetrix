import Permission, {PermissionId} from "./permission.model";
import Role from "./role.model";
import User from "../users/user.model";

export async function seedPermissions() {
    const permissions = Object.values(PermissionId);

    for (const permission of permissions) {
        await Permission.findOrCreate({
            where: {
                id: permission,
            },
        });
    }

    //Default SysAdmin role
    await Role.findOrCreate({
        where:{
            name: "System Administrator",
            priority: 1,
            description: "The Default role for the initial user",
            permissions
        }
    });

    //Default SysAdmin User
    const [sysAdmin, sysAdminCreated]: [User, boolean] = await User.findOrCreate({
        where:{
            username: "admin",
            first_name: "System Administrator",
            email: "admin@aerotrixlabs.com"
        },
    })

}