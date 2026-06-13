import express, { Request, Response, Router } from "express";
import AuthController from "./auth.controller";
import { validateBody } from "../../middleware/validateBody.middleware";
import { authenticateJwt } from "../../middleware/authenticateJwt.middleware";
import { loginSchema, registerSchema, refreshTokenSchema, logoutSchema } from "./auth.validation";

const router: Router = express.Router();
const authController: AuthController = new AuthController();

router.get(
    "/me",
    authenticateJwt,
    authController.me
);

router.post(
    "/register",
    validateBody(registerSchema),
    authController.register
);

router.post(
    "/login",
    validateBody(loginSchema),
    authController.login
);

router.post(
    "/logout",
    validateBody(logoutSchema),
    authController.logout
)

router.post(
    "/forgot-password",
    async (req: Request, res: Response) => {
    
    }
);

router.post(
    "/reset-password",
    async (req: Request, res: Response) => {
    
    }
);

router.post(
    "/refresh",
    validateBody(refreshTokenSchema),
    authController.refresh
);

router.post("/logout", async (req: Request, res: Response) => {
    
})

export default router;