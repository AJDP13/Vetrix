import express, { Request, Response, Router } from "express";
import UserController from "./user.controller";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";
import {validateBody} from "../../middleware/validateBody.middleware";
import {registerSchema} from "../auth/auth.validation";
import {changePasswordSchema, updateMeSchema, updateUserSchema} from "./user.validation";

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

router.patch( //NOTE: For a user to update their own profile
    "/me",
    validateBody(updateMeSchema),
    userController.patchMe
)

router.patch( //NOTE: For users to update their own password
    "/change-password",
    validateBody(changePasswordSchema),
    userController.changePassword
);

router.patch( //NOTE: For admin to update a user's profile //Permission check for users.edit
    "/:id",
    validateBody(updateUserSchema),
    userController.updateUser
)

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