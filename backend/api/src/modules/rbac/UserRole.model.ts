import { CreationOptional, DataTypes, InferAttributes, InferCreationAttributes, Model } from "sequelize";
import sequelize from "../../config/database";

export default class UserRole extends Model<InferAttributes<UserRole>,InferCreationAttributes<UserRole>> {
    declare id: CreationOptional<string>;

    declare role_id: string;
    declare user_id: string;

    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
}

UserRole.init({
    id:{
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },

    role_id:{
        type: DataTypes.UUID,
        allowNull:false
    },

    user_id:{
        type: DataTypes.UUID,
        allowNull:false
    },

    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
},{
    sequelize,
    tableName: "vt.UserRole",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at"
});