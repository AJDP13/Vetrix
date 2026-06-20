import { CreationOptional, DataTypes, InferAttributes, InferCreationAttributes, Model } from "sequelize";
import sequelize from "../../config/database";
import {PermissionId} from "./permission.model";

export default class RolePermission extends Model<InferAttributes<RolePermission>,InferCreationAttributes<RolePermission>> {
    declare id: CreationOptional<string>;

    declare role_id: string;
    declare permission_id: PermissionId;

    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
}

RolePermission.init({
    id:{
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },

    role_id:{
        type: DataTypes.UUID,
        allowNull:false
    },

    permission_id:{
        type: DataTypes.UUID,
        allowNull:false
    },

    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
},{
    sequelize,
    tableName: "vt.RolePermission",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at"
});