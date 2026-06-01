import {Request, Response} from "express";

import userService from "./user.service";
import NotFoundError from "../../shared/errors/NotFoundError";
import { IdParam } from "../../shared/types/route.types";

export async function getUser(req: Request<IdParam>, res: Response) {
    const {id} = req.params;

    const user = await userService.getUserById(id);

    if(user == null) throw new NotFoundError ("User not found");

    return res.json(user)
}

export async function updateUser(req: Request<IdParam>, res:Response){
    const {id} = req.params;
}