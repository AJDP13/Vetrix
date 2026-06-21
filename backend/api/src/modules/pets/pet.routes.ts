import express, {Router} from "express";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";
import {hasPermission} from "../../middleware/hasPermission.middleware";
import {PermissionId} from "../rbac/permission.model";
import PetController from "./pet.controller";
import {validateBody} from "../../middleware/validateBody.middleware";
import {createPetSchema, updatePetSchema} from "./pet.validation";

const router: Router = express.Router();
const petController: PetController = new PetController();

router.use(authenticateJwt);

router.get( //NOTE: Searches pet by parameters
    "/search",
    hasPermission(PermissionId.PETS_VIEW)
);

router.get( //NOTE: Gets pet by ID
    "/:id",
    hasPermission(PermissionId.PETS_VIEW),
    petController.getPet
);

router.get( //NOTE: Gets all Pets
    "/",
    hasPermission(PermissionId.PETS_VIEW),
    petController.getPets
)

router.patch( //NOTE: Updates a current Pet
    "/:id",
    validateBody(updatePetSchema),
    hasPermission(PermissionId.PETS_EDIT),
    petController.updatePet
)

router.post( //NOTE: Creates a new Pet
    "/",
    validateBody(createPetSchema),
    hasPermission(PermissionId.PETS_CREATE),
    petController.createPet
)

router.delete( //NOTE: Soft-delets a Pet
    "/:id",
    hasPermission(PermissionId.PETS_ARCHIVE),
    petController.archivePet
)

export default router;