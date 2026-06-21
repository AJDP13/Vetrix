import express, {Router} from "express";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";
import {hasPermission} from "../../middleware/hasPermission.middleware";
import {PermissionId} from "../rbac/permission.model";

const router: Router = express.Router();

router.use(authenticateJwt);

router.get( //NOTE: Searches pet by parameters
    "/search",
    hasPermission(PermissionId.PETS_VIEW)
);

router.get( //NOTE: Gets pet by ID
    "/:id",
    hasPermission(PermissionId.PETS_VIEW)
);

router.get( //NOTE: Gets all Pets
    "/",
    hasPermission(PermissionId.PETS_VIEW)
)

router.patch( //NOTE: Updates a current Pet
    "/:id",
    hasPermission(PermissionId.PETS_EDIT)
)

router.post( //NOTE: Creates a new Pet
    "/",
    hasPermission(PermissionId.PETS_CREATE)
)

router.delete( //NOTE: Soft-delets a Pet
    "/:id",
    hasPermission(PermissionId.PETS_ARCHIVE)
)

export default router;