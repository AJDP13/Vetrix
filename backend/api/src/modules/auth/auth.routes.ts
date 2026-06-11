import express, { Request, Response, Router } from "express";
import AuthController from "./auth.controller";
import { validateBody } from "../../middleware/validateBody.middleware";
import { loginSchema, registerSchema } from "./auth.validation";

const router: Router = express.Router();
const authController: AuthController = new AuthController();

router.post("/register", validateBody(registerSchema), authController.register)

router.post("/login", validateBody(loginSchema), authController.login)

router.post("/forgot-password", async (req: Request, res: Response) => {
    
})

router.post("/reset-password", async (req: Request, res: Response) => {
    
})

router.post("/refresh", async (req: Request, res: Response) => {
    
})

router.post("/logout", async (req: Request, res: Response) => {
    
})

export default router;