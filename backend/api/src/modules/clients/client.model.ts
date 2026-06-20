import {
    BelongsToManySetAssociationsMixin,
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model
} from "sequelize";
import sequelize from "../../config/database";

export default class Client extends Model<InferAttributes<Client>,InferCreationAttributes<Client>> {
    declare id: CreationOptional<string>;

    declare first_name: string;
    declare last_name: CreationOptional<string>;
    declare email: string;
    declare phone: CreationOptional<string>;

    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
    declare deleted_at: CreationOptional<Date>;
}

Client.init({
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
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

    phone: {
        type: DataTypes.STRING,
        allowNull: true
    },
    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    deleted_at: DataTypes.DATE
},{
    sequelize,
    tableName: "vt.clients",
    paranoid:true,
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    deletedAt: "deleted_at"
});