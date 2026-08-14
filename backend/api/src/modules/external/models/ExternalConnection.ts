import {
    BelongsToManySetAssociationsMixin,
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model
} from "sequelize";
import sequelize from "../../../config/database";
import { ExternalProvider } from "./ExternalProvider";

export default class ExternalConnection extends Model<InferAttributes<ExternalConnection>,InferCreationAttributes<ExternalConnection>> {
    declare id: CreationOptional<string>;

    declare provider: ExternalProvider;
    declare name: string;
    declare access_token: string;
    declare is_active: boolean;
    
    
    declare last_sync_at: CreationOptional<Date>;
    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
    declare deleted_at: CreationOptional<Date>;
}

ExternalConnection.init({
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },
    provider:{
        type: DataTypes.STRING,
        allowNull: false,
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false
    },
    access_token:{
        type: DataTypes.STRING,
        allowNull:false
    },
    is_active:{
        type: DataTypes.BOOLEAN,
        defaultValue: false
    },
    
    last_sync_at: DataTypes.DATE,
    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    deleted_at: DataTypes.DATE
},{
    sequelize,
    tableName: "vt.external_connections",
    paranoid:true,
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    deletedAt: "deleted_at"
});