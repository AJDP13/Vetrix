import express, { Request, Response, Router } from "express";
import UserController from "./user.controller";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";
import {validateBody} from "../../middleware/validateBody.middleware";
import {registerSchema} from "../auth/auth.validation";

const router: Router = express.Router();
const userController = new UserController();

router.use(authenticateJwt); //All /user endpoints will need JWT Authentication

router.get(
    "/search",
    userController.searchUsers
);

router.get(
    "/:id",
    userController.getUser
);

router.get( //TODO: Permission check for users.view
    "/",
    userController.getAllUsers
)

router.patch("/:id", async(req : Request, res: Response)=>{
    //Update user Details
})

router.patch(
    "/:id/deactivate",
    userController.deactivateUser
);

router.post( //TODO: Permission check for users.create
    "/",
    validateBody(registerSchema),
    userController.createUser
)

export default router;