import {Request, Response} from "express";
import RBACService from "./rbac.service";

export default class RBACController {
    rbacService: RBACService = new RBACService();

    createRole = async(req: Request, res: Response) =>{

    }

}