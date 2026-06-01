import express from "express";
import sequelize from "./config/database";
import { SequelizeStorage, Umzug } from "umzug";
import env from "./config/env";
import { errorHandler } from "./middleware/error.middleware";

import authRoutes from "./modules/auth/auth.routes";
import userRoutes from "./modules/users/user.routes";

const app = express();

const {port} = env;

async function start(): Promise<void> {
    try{
        await sequelize.authenticate();

        await sequelize.sync({
            alter:true
        });

        console.log("Database connection success");

        app.listen(port, ()=>{
            console.log("API Running on port: " + port);
        })
    }catch(err){
        console.error(err)
        process.exit(1);
    }
}

start();

/*Import Routes*/
app.use("/auth", authRoutes)
app.use("/users", userRoutes)

app.use(errorHandler);