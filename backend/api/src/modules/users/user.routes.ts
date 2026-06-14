import express, { Request, Response, Router } from "express";
import UserController from "./user.controller";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";

const router: Router = express.Router();
const userController = new UserController();

router.use(authenticateJwt); //All /user endpoints will need JWT Authentication

router.get(
    "/:id",
    userController.getUser
);

router.get( //TODO: Need to check if user has permissions to view users
    "/",
    userController.getAllUsers
)

router.patch("/:id", async(req : Request, res: Response)=>{
    //Update user Details
})

export default router;