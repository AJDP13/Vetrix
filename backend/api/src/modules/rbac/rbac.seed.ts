import Permission, {PermissionId} from "./permission.model";

export async function seedPermissions() {
    const permissions = Object.values(PermissionId);

    for (const permission of permissions) {
        await Permission.findOrCreate({
            where: {
                id: permission,
            },
        });
    }
}