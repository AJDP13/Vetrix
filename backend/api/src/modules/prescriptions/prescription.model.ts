import {
    CreationOptional,
    DataTypes,
    InferAttributes,
    InferCreationAttributes,
    Model, NonAttribute
} from "sequelize";
import sequelize from "../../config/database";
import Pet from "../pets/pet.model";

export enum PrescriptionState{
    VOID = "void",
    DRAFT = "draft",
    ACTIVE = "active"
}

export default class Prescription extends Model<InferAttributes<Prescription>,InferCreationAttributes<Prescription>> {
    declare id: CreationOptional<string>;

    declare pet_id: string;

    declare prescribed_at: Date;
    declare expires_at: Date;
    declare max_repeats: CreationOptional<number>;
    declare repeat_interval_days: CreationOptional<number>;
    declare prescribed_by: CreationOptional<string>;
    declare prescribing_practice: CreationOptional<string>; //To become part of reference data later - Vet practice info will be imported from national database

    declare notes: string | null;

    declare state: PrescriptionState


    declare created_at: CreationOptional<Date>;
    declare updated_at: CreationOptional<Date>;
    declare deleted_at: CreationOptional<Date>;

    declare pet: NonAttribute<Pet>;

    isActiveAndValid(): boolean{
        return this.state == PrescriptionState.ACTIVE && (this.expires_at > new Date(Date.now()));
    }
}

Prescription.init({
    id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },

    pet_id:{
        type: DataTypes.UUID,
        unique: false,
        allowNull: false
    },

    prescribed_at:{
        type: DataTypes.DATE,
        allowNull: false
    },

    expires_at:{
        type: DataTypes.DATE,
        allowNull: false
    },

    max_repeats:{
        type: DataTypes.INTEGER,
        allowNull:false,
        defaultValue: 1
    },

    repeat_interval_days:{
        type: DataTypes.INTEGER,
        allowNull:false,
        defaultValue: 0,
    },

    prescribed_by:{
        type: DataTypes.STRING,
        allowNull:false,
        defaultValue: ""
    },

    prescribing_practice:{
        type: DataTypes.STRING,
        allowNull:false,
        defaultValue: ""
    },

    notes:{
        type: DataTypes.TEXT,
        allowNull: true
    },

    state:{
        type: DataTypes.ENUM,
        values: Object.keys(PrescriptionState),
        defaultValue: PrescriptionState.DRAFT,
        allowNull:false
    },

    created_at: DataTypes.DATE,
    updated_at: DataTypes.DATE,
    deleted_at: DataTypes.DATE
},{
    sequelize,
    tableName: "vt.prescriptions",
    paranoid:true,
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at",
    deletedAt: "deleted_at"
});