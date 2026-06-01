import express, { Request, Response, Router } from "express";
import * as userController from "./user.controller";

const router: Router = express.Router();

router.get("/:id", userController.getUser)

router.post("/:id", async(req : Request, res: Response)=>{
    //Update user Details
})

export default router;