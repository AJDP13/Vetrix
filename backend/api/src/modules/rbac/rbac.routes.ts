import express, { Request, Response, Router } from "express";
import {validateBody} from "../../middleware/validateBody.middleware";
import {createRoleSchema} from "./rbac.validation";
import RBACController from "./rbac.controller";

const router: Router = express.Router();

const rbacController: RBACController = new RBACController();

router.post( //Create Role Endpoint - TODO: Permission check roles.create
    "/create-role",
    validateBody(createRoleSchema),
    rbacController.createRole
)

export default router;