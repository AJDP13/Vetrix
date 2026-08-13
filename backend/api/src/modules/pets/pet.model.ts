import {
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model, NonAttribute
} from "sequelize";
import sequelize from "../../config/database";
import Client from "../clients/client.model";
import Prescription from "../prescriptions/prescription.model";

export default class Pet extends Model<InferAttributes<Pet>,InferCreationAttributes<Pet>> {
    declare id: CreationOptional<string>;

    declare name: string;
    declare date_of_birth: Date;
    declare owner_id: string;

    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
    declare deleted_at: CreationOptional<Date>;

    declare owner?: NonAttribute<Client>;
    declare prescriptions: NonAttribute<Prescription>
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

    date_of_birth:{
        type: DataTypes.DATE,
        allowNull: false
    },

    owner_id:{
        type: DataTypes.UUID,
        allowNull:false,
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
    deletedAt: "deleted_at",
    scopes:{
        withPrescriptions:{
            include:[{
                model: Prescription,
                as: "prescriptions"
            }]
        },
        withOwner:{
            include:[{
                model: Client,
                as: "owner",
                paranoid: false
            }]
        }
    }
});