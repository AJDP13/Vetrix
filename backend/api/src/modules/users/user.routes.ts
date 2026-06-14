import express, { Request, Response, Router } from "express";
import UserController from "./user.controller";

const router: Router = express.Router();
const userController = new UserController();

router.get("/:id", userController.getUser)

router.get(
    "/",
    userController.getAllUsers
)

router.post("/:id", async(req : Request, res: Response)=>{
    //Update user Details
})

export default router;