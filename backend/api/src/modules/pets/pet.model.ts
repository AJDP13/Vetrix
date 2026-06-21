import {
    BelongsToManySetAssociationsMixin,
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model
} from "sequelize";
import sequelize from "../../config/database";
import Client from "../clients/client.model";

export default class Pet extends Model<InferAttributes<Pet>,InferCreationAttributes<Pet>> {
    declare id: CreationOptional<string>;

    declare name: string;

    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
    declare deleted_at: CreationOptional<Date>;

    declare owner?: Client;
}

Pet.init({
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },

    name:{
        type: DataTypes.STRING,
        unique: false,
        allowNull: false
    },
    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    deleted_at: DataTypes.DATE
},{
    sequelize,
    tableName: "vt.pets",
    paranoid:true,
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    deletedAt: "deleted_at"
});