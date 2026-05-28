import express from "express";
import sequelize from "./config/database.js";
import env from "./config/env.js";

const app = express();

const {port} = env;

async function start(){
    try{
        await sequelize.authenticate();

        console.log("Database connection success");

        app.listen(port, ()=>{
            console.log("API Running on port: " + port);
        })
    }catch(err){
        console.error(err)
    }
}

start();