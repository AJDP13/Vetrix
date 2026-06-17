import {
    BelongsToManyAddAssociationsMixin,
    BelongsToManySetAssociationsMixin,
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model
} from "sequelize";
import sequelize from "../../config/database";
import Permission from "./permission.model";
import User from "../users/user.model";

export default class Role extends Model<InferAttributes<Role>,InferCreationAttributes<Role>> {
    declare id: CreationOptional<string>;

    declare name: string;
    declare description: CreationOptional<string>;
    declare priority: CreationOptional<bigint>;

    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
    declare deleted_at: CreationOptional<Date>;

    declare permissions?: Permission[];

    declare setPermissions: BelongsToManySetAssociationsMixin<Permission, string>;
    declare addPermissions: BelongsToManyAddAssociationsMixin<Permission, string>;

}

Role.init({
    id:{
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },

    name:{
        type: DataTypes.STRING,
        allowNull:false
    },

    description:{
        type: DataTypes.TEXT,
        allowNull: true
    },

    priority:{
        type: DataTypes.INTEGER,
        allowNull:false,
        defaultValue: 1
    },

    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    deleted_at: {
        type: DataTypes.DATE,
        allowNull: true
    }
},{
    sequelize,
    tableName: "vt.roles",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    deletedAt: "deleted_at",
    paranoid: true,
    scopes:{
        withPermissions:{
            include:[{
                model: Permission,
                as: "permissions"
            }]
        },
        withUsers:{
            include: [{
                model: User,
                as: "users",
            }]
        }
    }
});