import express, {Router} from "express";
import {authenticateJwt} from "../../middleware/authenticateJwt.middleware";

const router: Router = express.Router();

router.use(authenticateJwt); //All /clients endpoints will need JWT Authentication

router.get( //NOTE: Searches client by parameters
    "/search",
);

router.get( //NOTE: Gets client by ID
    "/:id",
);

router.get( //NOTE: Gets all Clients
    "/",
)

router.patch( //NOTE: Updates a current Client
    "/:id",
)

router.post( //NOTE: Creates a new Client
    "/",
)

router.delete( //NOTE: Soft-delets a Client
    "/:id"
)

export default router;