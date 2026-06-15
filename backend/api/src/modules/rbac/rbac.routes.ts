import express, {Router} from "express";
import {validateBody} from "../../middleware/validateBody.middleware";
import {createRoleSchema} from "./rbac.validation";
import RBACController from "./rbac.controller";
import {hasPermission} from "../../middleware/hasPermission.middleware";
import {PermissionId} from "./permission.model";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";

const router: Router = express.Router();
router.use(authenticateJwt);

const rbacController: RBACController = new RBACController();

router.get(
    "/roles",
    hasPermission(PermissionId.ROLES_VIEW),
    rbacController.viewRoles
);

router.post( //Create Role Endpoint - TODO: Permission check roles.create
    "/roles",
    validateBody(createRoleSchema),
    hasPermission(PermissionId.ROLES_CREATE),
    rbacController.createRole
);

export default router;