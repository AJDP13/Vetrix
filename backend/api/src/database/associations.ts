import User from "../modules/users/user.model";
import Token from "../modules/auth/token.model";

export function setupAssociations() {

    User.hasMany(Token, {
        foreignKey: "user_id",
        as: "tokens"
    });

    Token.belongsTo(User, {
        foreignKey: "user_id",
        as: "user"
    });

}