module.exports = (sequelize, DataTypes) => {
    const User = sequelize.define("User", {
        id: {
            type: DataTypes.UUID,
            defaultValue: DataTypes.UUIDV4,
            primaryKey: true
        },

        username: {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true
        },
        
        email: {
            type: DataTypes.STRING,
            allowNull:true,
            unique: true
        },

        password_hash: {
            type: DataTypes.STRING,
            allowNull: false
        },

        is_active: {
            type: DataTypes.BOOLEAN,
            defaultValue: true
        }

    }, {
        tableName: "vt.users",
        timestamps: true,
        createdAt: "created_at",
        updatedAt: "updated_at"
    });

    return User;
};