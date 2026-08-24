import {
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model
} from "sequelize";
import sequelize from "../../config/database";

export default class Order extends Model<InferAttributes<Order>,InferCreationAttributes<Order>> {
    declare id: CreationOptional<string>;

    declare client_id: string;

    declare comments: string | null;

    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
    declare deleted_at: CreationOptional<Date>;

    // declare products: CreationOptional<[Product]>;
}

Order.init({
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },

    client_id:{
        type: DataTypes.UUID,
        allowNull: false
    },

    comments:{
        type: DataTypes.STRING,
        allowNull: true
    },

    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    deleted_at: DataTypes.DATE
},{
    sequelize,
    tableName: "vt.orders",
    paranoid:true,
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    deletedAt: "deleted_at",
    scopes:{
        withProducts:{

        }
    }
});