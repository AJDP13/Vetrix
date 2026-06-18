import express, {Router} from "express";
import {validateBody} from "../../middleware/validateBody.middleware";
import {createRoleSchema, updateRoleSchema, updateUserRolesSchema} from "./rbac.validation";
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

router.post( //Create Role Endpoint
    "/roles",
    validateBody(createRoleSchema),
    hasPermission(PermissionId.ROLES_CREATE),
    rbacController.createRole
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

router.delete(
    "/roles/:roleId",
    hasPermission(PermissionId.ROLES_DELETE),
    rbacController.deleteRole
)

//User Roles Management
router.get(
    "/users/:id/permissions",
    hasPermission(PermissionId.ROLES_VIEW),
    rbacController.getUserPermissions
);

router.get(
    "/users/:id/roles",
    hasPermission(PermissionId.ROLES_VIEW),
    rbacController.getUserRoles
);

router.patch(
    "/users/:id/roles",
    validateBody(updateUserRolesSchema),
    hasPermission(PermissionId.ROLES_MANAGE_USERS),
    rbacController.updateUserRoles
)

export default router;