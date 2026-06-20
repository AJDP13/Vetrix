import { CreationOptional, DataTypes, InferAttributes, InferCreationAttributes, Model } from "sequelize";
import sequelize from "../../config/database";

export enum PermissionId{
    ROLES_CREATE = "roles.create",
    ROLES_VIEW = "roles.view",
    ROLES_EDIT = "roles.edit",
    ROLES_DELETE = "roles.delete",

    ROLES_MANAGE_USERS = "roles.manage_users",

    USERS_CREATE = "users.create",
    USERS_VIEW = "users.view",
    USERS_EDIT = "users.edit",
    USERS_DEACTIVATE = "users.deactivate",

    CLIENTS_CREATE = "clients.create",
    CLIENTS_VIEW = "clients.view",
    CLIENTS_EDIT = "clients.edit",
    CLIENTS_ARCHIVE = "clients.archive",

    DRUGS_CREATE = "drugs.create",
    DRUGS_VIEW = "drugs.view",
    DRUGS_EDIT = "drugs.edit",
    DRUGS_DELETE = "drugs.delete",

    PRESCRIPTIONS_CREATE = "prescriptions.create",
    PRESCRIPTIONS_VIEW = "prescriptions.view",
    PRESCRIPTIONS_EDIT = "prescriptions.edit",
    PRESCRIPTIONS_DELETE = "prescriptions.delete"
}

export default class Permission extends Model<InferAttributes<Permission>,InferCreationAttributes<Permission>> {
    declare id: string;
    declare description: CreationOptional<string>;

    declare createdAt: CreationOptional<Date>;
    declare updatedAt: CreationOptional<Date>;
}

Permission.init({
    id:{
        type: DataTypes.STRING,
        primaryKey: true
    },

    description:{
        type: DataTypes.TEXT,
        allowNull: true,
        defaultValue: ""
    },

    createdAt: DataTypes.DATE,
    updatedAt: DataTypes.DATE,
},{
    sequelize,
    tableName: "vt.permissions",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at"
});