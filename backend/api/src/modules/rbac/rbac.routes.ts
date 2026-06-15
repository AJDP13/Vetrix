import express, {Router} from "express";
import {validateBody} from "../../middleware/validateBody.middleware";
import {createRoleSchema, updateRoleSchema} from "./rbac.validation";
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

router.get(
    "/roles/:roleId",
    hasPermission(PermissionId.ROLES_VIEW),
    rbacController.getRole
)

router.patch( //Updates role information (name, desc, perms, priority)
    "/roles/:roleId",
    validateBody(updateRoleSchema),
    hasPermission(PermissionId.ROLES_EDIT),
    rbacController.editRole
)

router.post( //Create Role Endpoint
    "/roles",
    validateBody(createRoleSchema),
    hasPermission(PermissionId.ROLES_CREATE),
    rbacController.createRole
);

export default router;