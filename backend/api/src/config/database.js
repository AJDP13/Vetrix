import {Sequelize, DataTypes} from "sequelize";


import env from "./env.js";

const {db} = env;

const sequelize = new Sequelize(
    db.name,
    db.user,
    db.password
, {
    host: db.host,
    dialect: "mysql"
})

export default sequelize