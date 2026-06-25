import Permission, {PermissionId} from "./permission.model";
import Role from "./role.model";
import User from "../users/user.model";
import bcrypt from "bcrypt"
import sequelize from "../../config/database";

export async function seedPermissions() {
    const transaction = await sequelize.transaction();
    const permissions = Object.values(PermissionId);

    await Permission.bulkCreate(permissions.map(p=>{
        return {
            id: p,
            description: p
        }
    }), {
        fields: ["id", "description"],
        updateOnDuplicate: ["description"],
        transaction
    })

    //Default SysAdmin role
    const [role, created] = await Role.findOrCreate({
        where:{
            name: "System Administrator",
            priority: 1,
            description: "The Default role for the initial user"
        },
        transaction
    });

    if(created) await role.setPermissions(permissions, {
        transaction
    });

    //Default SysAdmin User
    const [sysAdmin, sysCreated] = await User.findOrCreate({
        where: {
            email: "admin@aerotrixlabs.com",
        },
        defaults: {
            username: "administrator",
            first_name: "System Administrator",
            password_hash: await bcrypt.hash("admin", 10),
            email: "admin@aerotrixlabs.com",
        },
        transaction,
    });

    await transaction.commit();
}