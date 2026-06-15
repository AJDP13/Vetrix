import { CreationOptional, DataTypes, InferAttributes, InferCreationAttributes, Model } from "sequelize";
import sequelize from "../../config/database";
import Permission from "./permission.model";

export default class Role extends Model<InferAttributes<Role>,InferCreationAttributes<Role>> {
    declare id: CreationOptional<string>;

    declare name: string;
    declare description: CreationOptional<string>;
    declare priority: CreationOptional<bigint>;

    declare createdAt: CreationOptional<Date>;
    declare updatedAt: CreationOptional<Date>;
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

    createdAt: DataTypes.DATE,
    updatedAt: DataTypes.DATE,
},{
    sequelize,
    tableName: "vt.roles",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at"
});