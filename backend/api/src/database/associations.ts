import User from "../modules/users/user.model";
import Token from "../modules/auth/token.model";
import Role from "../modules/rbac/role.model";
import UserRole from "../modules/rbac/UserRole.model";
import Permission from "../modules/rbac/permission.model";
import RolePermission from "../modules/rbac/RolePermission.model";
import Client from "../modules/clients/client.model";
import Pet from "../modules/pets/pet.model";
import Prescription from "../modules/prescriptions/prescription.model";
import ExternalClient from "../modules/external/models/ExternalClient";
import ExternalConnection from "../modules/external/models/ExternalConnection";
import Order from "../modules/orders/order.model";

export function setupAssociations() {

    //User associations
    User.hasMany(Token, {
        foreignKey: "user_id",
        as: "tokens"
    });
    User.belongsToMany(Role,{
        through: UserRole,
        foreignKey: "user_id",
        otherKey: "role_id",
        as: "roles"
    })

    //Token associations
    Token.belongsTo(User, {
        foreignKey: "user_id",
        as: "user"
    });

    //Role associations
    Role.belongsToMany(User,{
        through: UserRole,
        foreignKey: "role_id",
        otherKey: "user_id",
        as: "users"
    });

    Role.belongsToMany(Permission, {
        through: RolePermission,
        foreignKey: "role_id",
        otherKey: "permission_id",
        as: "permissions"
    });

    //Permission Associations
    Permission.belongsToMany(Role, {
        through: RolePermission,
        foreignKey: "permission_id",
        otherKey: "role_id",
        as: "roles"
    });

    //Client Associations
    Client.hasMany(Pet, {
        foreignKey:"owner_id",
        as: "pets"
    });

    Client.hasOne(ExternalClient, {
        foreignKey: "client_id",
        as: "external_client"
    })

    Client.hasMany(Order, {
        foreignKey: "client_id",
        as: "orders"
    })

    //Pet Associations
    Pet.belongsTo(Client, {
        foreignKey:"owner_id",
        as:"owner"
    });

    Pet.hasMany(Prescription, {
        foreignKey: "pet_id",
        as: "prescriptions"
    });

    //Prescription Associations
    Prescription.belongsTo(Pet, {
        foreignKey: "pet_id",
        as: "pet"
    })

    //ExternalClient Associations
    ExternalClient.belongsTo(ExternalConnection, {
        foreignKey: "provider_id",
        as: "provider"
    })

    ExternalClient.belongsTo(Client, {
        foreignKey: "client_id",
        as: "client"
    })

    //ExternalConnection Associations
    ExternalConnection.hasMany(ExternalClient, {
        foreignKey: "provider_id",
        as: "external_clients"
    })

    //Order Associations
    Order.belongsTo(Client, {
        foreignKey: "client_id",
        as: "client"
    })

    
}