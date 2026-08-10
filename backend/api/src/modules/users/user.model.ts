import {
    BelongsToManySetAssociationsMixin,
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model
} from "sequelize";
import sequelize from "../../config/database";
import Role from "../rbac/role.model";

export default class User extends Model<InferAttributes<User>,InferCreationAttributes<User>> {
    declare id: CreationOptional<string>;

    declare username: string;
    declare first_name: string;
    declare last_name: CreationOptional<string>;
    declare email: string;
    declare password_hash: string;

    declare is_active: CreationOptional<boolean>;

    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;

    declare roles?: Role[];

    declare setRoles: BelongsToManySetAssociationsMixin<Role, string>;
}

User.init({
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },

    username: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
    },

    first_name:{
        type: DataTypes.STRING,
        allowNull: false,
    },

    last_name: {
        type: DataTypes.STRING,
        allowNull: true,
    },

    email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
    },

    password_hash: {
        type: DataTypes.STRING,
        allowNull: false
    },

    is_active: {
        type: DataTypes.BOOLEAN,
        defaultValue: true
    },
    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    },{
        sequelize,
        tableName: "vt.users",
        timestamps: true,
        createdAt: "created_at",
        updatedAt: "updated_at",
        scopes:{
            withRoles: () => ({
                include: [{
                    association: "roles",
                }],
            }),
            withRolesAndPermissions: () => ({
                include: [{
                    association: "roles",
                    include:[{
                        association: "permissions"
                    }]
                }],
            })
        }
    });