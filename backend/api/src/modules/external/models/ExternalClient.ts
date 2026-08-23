import {
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model
} from "sequelize";
import sequelize from "../../../config/database";

export default class ExternalClient extends Model<InferAttributes<ExternalClient>,InferCreationAttributes<ExternalClient>> {
    declare id: CreationOptional<string>;

    declare connection_id: string;
    declare client_id: string | null;
    declare external_id: string;
    declare external_email: string | null;
    declare external_data: Record<string,unknown> | null;

    
    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
}

ExternalClient.init({
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },

    connection_id: {
        type: DataTypes.UUID,
        allowNull: false,
    },

    client_id:{
        type: DataTypes.UUID,
        allowNull: true
    },

    external_id:{
        type: DataTypes.STRING,
        allowNull: false
    },

    external_email:{
        type: DataTypes.STRING,
        allowNull: true,
    },

    external_data: {
        type: DataTypes.JSON,
        allowNull: true
    },

    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
},{
    sequelize,
    tableName: "vt.external_clients",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    indexes: [
        {
            unique: true,
            fields: ["connection_id", "external_id"]
        }
    ]
});