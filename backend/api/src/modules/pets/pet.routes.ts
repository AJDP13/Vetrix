import express, {Router} from "express";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";
import {hasPermission} from "../../middleware/hasPermission.middleware";
import {PermissionId} from "../rbac/permission.model";

const router: Router = express.Router();

router.use(authenticateJwt);

router.get( //NOTE: Searches pet by parameters
    "/search",
);

router.get( //NOTE: Gets pet by ID
    "/:id",
);

router.get( //NOTE: Gets all Pets
    "/",
)

router.patch( //NOTE: Updates a current Pet
    "/:id",
)

router.post( //NOTE: Creates a new Pet
    "/",
)

router.delete( //NOTE: Soft-delets a Pet
    "/:id",
)

export default router;