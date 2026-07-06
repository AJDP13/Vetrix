import express, {Router} from "express";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";
import ClientController from "./client.controller";
import {hasPermission} from "../../middleware/hasPermission.middleware";
import {PermissionId} from "../rbac/permission.model";

const router: Router = express.Router();
const clientController: ClientController = new ClientController();

router.use(authenticateJwt); //All /clients endpoints will need JWT Authentication

// router.get( //NOTE: Searches client by parameters
//     "/search",
//     hasPermission(PermissionId.CLIENTS_VIEW),
//     clientController.searchClients
// );

router.get( //NOTE: Gets client by ID
    "/:id",
    hasPermission(PermissionId.CLIENTS_VIEW),
    clientController.getClient
);

router.get( //NOTE: Gets all Clients
    "/",
    hasPermission(PermissionId.CLIENTS_VIEW),
    clientController.searchClients
)

router.patch( //NOTE: Updates a current Client
    "/:id",
    hasPermission(PermissionId.CLIENTS_EDIT),
    clientController.updateClient
)

router.post( //NOTE: Creates a new Client
    "/",
    hasPermission(PermissionId.CLIENTS_CREATE),
    clientController.createClient
)

router.delete( //NOTE: Soft-delets a Client
    "/:id",
    hasPermission(PermissionId.CLIENTS_ARCHIVE),
    clientController.archiveClient
)

export default router;