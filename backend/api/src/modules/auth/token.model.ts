import { CreationOptional, DataTypes, InferAttributes, InferCreationAttributes, Model } from "sequelize";
import sequelize from "../../config/database";

export enum TokenType{
    REFRESH = "REFRESH",
    EMAIL_VERIFY = "EMAIL_VERIFY",
    PASSWORD_RESET = "PASSWORD_RESET"
}

export default class Token extends Model<InferAttributes<Token>,InferCreationAttributes<Token>> {
    declare id: CreationOptional<string>;
    declare token_hash: string;
    declare token_type: TokenType;
    declare user_id: string;

    declare expires_at: Date;
    declare used_at: Date | null;
    declare revoked_at: Date | null;

    declare createdAt: CreationOptional<Date>;
    declare updatedAt: CreationOptional<Date>;
}

Token.init({
    id:{
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true
    },
    token_hash:{
        type: DataTypes.STRING,
        allowNull: false,
        unique: true
    },
    token_type: {
        type: DataTypes.ENUM,
        values: Object.values(TokenType),
        allowNull: false
    },
    user_id:{
        type: DataTypes.UUID,
        allowNull: false,
    },
    expires_at:{
        type: DataTypes.DATE,
        allowNull: false,
    },
    used_at:{
        type:DataTypes.DATE,
        allowNull: true,

    },
    revoked_at:{
        type:DataTypes.DATE,
        allowNull: true,

    },
    createdAt: DataTypes.DATE,
    updatedAt: DataTypes.DATE,
    },{
    sequelize,
    tableName: "vt.tokens",
    timestamps: true,
    createdAt: "created_at",
    updatedAt: "updated_at"
});