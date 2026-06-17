import dotenv from "dotenv"

dotenv.config();

const env = {
    port: Number(process.env.PORT ?? 3000),
    jwt:{
        secret: process.env.JWT_SECRET || "",
        expiry: Number(process.env.JWT_EXPIRY) || 900
    },
    db:{
        host: process.env.DB_HOST || "",
        port: parseInt(process.env.DB_PORT || "3306"),
        name: process.env.DB_NAME || "",
        user: process.env.DB_USER || "",
        password: process.env.DB_PASSWORD || "",
        dialect: process.env.DB_DIALECT || ""
    }
};

export default env;