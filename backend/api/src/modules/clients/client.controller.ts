import {Request, Response} from "express";
import {ClientResponse, CreateClientDto, SearchAllClientsDto, UpdateClientDto} from "./client.types";
import ClientService from "./client.service";
import ApiError from "../../shared/errors/ApiError";
import env from "../../config/env"

const clientService = new ClientService();

export default class ClientController{
    getClient = async(req: Request, res: Response) => {
        const id = req.params.id as string;

        if(!id) throw new ApiError(400, "Id parameter is required");

        const result = await clientService.getClient(id);

        return res.status(200).json({
            success:true,
            data: result
        })
    }

    searchClients = async(req: Request, res: Response)=>{
        if(!req.query.pageLimit || !req.query.page) throw new ApiError(400, "Invalid Page or Page Limit")
        
        var pageLimit = Math.min(
            parseInt(req.query.pageLimit as string),
            env.constants.max_page_limit_clients
        );
        var page = parseInt(req.query.page as string)

        const params: SearchAllClientsDto = {
            page,
            pageLimit
        };

        const result = await clientService.searchAllClients(params);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    updateClient = async(req: Request, res: Response) => {
        const data: UpdateClientDto = req.body;

        const result: ClientResponse = await clientService.updateClient(data);

        return res.status(200).json({
            success:true,
            data: result
        })
    }

    createClient = async(req: Request, res:Response) => {
        const data: CreateClientDto = req.body;
        const result: ClientResponse = await clientService.createClient(data);

        return res.status(201).json({
            success:true,
            data:result
        })
    }

    archiveClient = async(req: Request, res: Response) => {
        const id: string = req.params.id as string;

        if(!id) throw new ApiError(400, "Client ID is required");

        await clientService.archiveClient(id);

        return res.status(200).json({
            success:true
        })
    }

}