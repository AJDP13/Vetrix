import express, { Request, Response, Router } from "express";
import AuthController from "./auth.controller";

const router: Router = express.Router();
const authController: AuthController = new AuthController();

router.post("/register", authController.register)

router.post("/login", authController.login)

router.post("/forgotPassword", async (req: Request, res: Response) => {
    
})

export default router;