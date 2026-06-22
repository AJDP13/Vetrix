import express, {Router} from "express";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";
import {hasPermission} from "../../middleware/hasPermission.middleware";
import {PermissionId} from "../rbac/permission.model";
import {validateBody} from "../../middleware/validateBody.middleware";
import PrescriptionController from "./prescription.controller";

const router: Router = express.Router();
const prescriptionController: PrescriptionController = new PrescriptionController();

router.use(authenticateJwt);

router.get( //NOTE: Gets prescription by ID
    "/:id",
    hasPermission(PermissionId.PRESCRIPTIONS_VIEW),
);

router.get( //NOTE: Gets all Prescriptions
    "/",
    hasPermission(PermissionId.PRESCRIPTIONS_VIEW),
)

router.patch( //NOTE: Updates a current Prescription - limited info updateable
    "/:id",
    hasPermission(PermissionId.PRESCRIPTIONS_EDIT),
)

router.post( //NOTE: Creates a new Prescription
    "/",
    hasPermission(PermissionId.PRESCRIPTIONS_CREATE),
)

router.delete( //NOTE: Soft-delets a Prescription
    "/:id",
    hasPermission(PermissionId.PRESCRIPTIONS_DELETE)
)

export default router;