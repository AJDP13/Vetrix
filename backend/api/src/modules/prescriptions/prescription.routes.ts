import express, {Router} from "express";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";
import {hasPermission} from "../../middleware/hasPermission.middleware";
import {PermissionId} from "../rbac/permission.model";
import {validateBody} from "../../middleware/validateBody.middleware";
import PrescriptionController from "./prescription.controller";
import {createPrescriptionSchema, updatePrescriptionSchema} from "./prescription.validation";

const router: Router = express.Router();
const prescriptionController: PrescriptionController = new PrescriptionController();

router.use(authenticateJwt);

router.get( //NOTE: Gets prescription by ID
    "/:id",
    hasPermission(PermissionId.PRESCRIPTIONS_VIEW),
    prescriptionController.getPrescription
);

router.get( //NOTE: Gets all Prescriptions
    "/",
    hasPermission(PermissionId.PRESCRIPTIONS_VIEW),
    prescriptionController.getAllPrescriptions
)

router.patch( //NOTE: Updates a current Prescription - limited info updateable
    "/:id",
    validateBody(updatePrescriptionSchema),
    hasPermission(PermissionId.PRESCRIPTIONS_EDIT),
    prescriptionController.updatePrescription
)

router.post( //NOTE: Creates a new Prescription
    "/",
    validateBody(createPrescriptionSchema),
    hasPermission(PermissionId.PRESCRIPTIONS_CREATE),
    prescriptionController.createPrescription
)

router.delete( //NOTE: Soft-deletes a Prescription
    "/:id",
    hasPermission(PermissionId.PRESCRIPTIONS_DELETE),
    prescriptionController.archivePrescription
)

export default router;