import express from "express";
import sequelize from "./config/database";
import env from "./config/env";
import { errorHandler } from "./middleware/error.middleware";
import authRoutes from "./modules/auth/auth.routes";
import userRoutes from "./modules/users/user.routes";
import { JwtPayload } from "jsonwebtoken";
import rbacRoutes from "./modules/rbac/rbac.routes";
import {setupAssociations} from "./database/associations";
import {seedPermissions} from "./modules/rbac/rbac.seed";
import clientRoutes from "./modules/clients/client.routes";
import petRoutes from "./modules/pets/pet.routes";
import prescriptionRoutes from "./modules/prescriptions/prescription.routes";

const app = express();

app.use(express.json());

const {port} = env;

declare global {
    namespace Express {
        export interface Request {
            user?: JwtPayload;
        }
    }
}

async function start(): Promise<void> {
    try{
        await sequelize.authenticate();

        await sequelize.sync({
            // alter:true
        });

        setupAssociations();

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
app.use("/rbac", rbacRoutes);
app.use("/clients", clientRoutes);
app.use("/pets", petRoutes);
app.use("/prescriptions", prescriptionRoutes);

app.post("/seed", async(req, res) => {
    await seedPermissions();
});

//Import Error Handling
app.use(errorHandler);