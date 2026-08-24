import {
    BelongsToManySetAssociationsMixin,
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model
} from "sequelize";
import sequelize from "../../../config/database";

export enum ExternalOrderStatus{
    CREATED = "created",

}

export default class ExternalOrder extends Model<InferAttributes<ExternalOrder>,InferCreationAttributes<ExternalOrder>> {
    declare id: CreationOptional<string>;

    declare connection_id: string;
    declare order_id: string | null;
    declare external_id: string;
    declare external_number: string;
    declare status: string;
    declare external_status: string;
    declare external_data: object | null;


    
    
    declare last_sync_at: CreationOptional<Date>;
    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
    declare deleted_at: CreationOptional<Date>;
}

ExternalOrder.init({
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },
    
    connection_id: {
        type: DataTypes.UUID,
        allowNull: false
    },

    order_id: {
        type: DataTypes.UUID,
        allowNull: true
    },

    external_id: {
        type: DataTypes.STRING,
        allowNull: false
    },

    external_number: {
        type: DataTypes.STRING,
        allowNull: false
    },

    status:{
        type: DataTypes.STRING,
        allowNull: false
    },

    external_status: {
        type: DataTypes.STRING,
        allowNull: false
    },

    external_data: {
        type: DataTypes.JSON,
        allowNull: true
    },
    
    last_sync_at: DataTypes.DATE,
    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    deleted_at: DataTypes.DATE
},{
    sequelize,
    tableName: "vt.external_orders",
    paranoid:true,
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    deletedAt: "deleted_at"
});