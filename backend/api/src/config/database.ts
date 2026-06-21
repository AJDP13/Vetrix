import {Sequelize} from "sequelize";


import env from "./env";

const {db} = env;

const sequelize = new Sequelize(
    db.name,
    db.user,
    db.password,
    {
    host: db.host,
    port: db.port,
    dialect: "mysql",
    pool:{
        max: 10,
        min: 2,
        acquire: 10000,
        idle: 10000
    }
})

export default sequelize