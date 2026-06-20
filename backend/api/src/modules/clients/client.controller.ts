import {Request, Response} from "express";
import {ClientResponse, CreateClientDto, GetAllClientsDto, UpdateClientDto} from "./client.types";
import ClientService from "./client.service";
import ApiError from "../../shared/errors/ApiError";

const clientService = new ClientService();

export default class ClientController{
    searchClients = async(req: Request, res: Response)=>{

    }

    getClient = async(req: Request, res: Response) => {
        const id = req.params.id as string;

        if(!id) throw new ApiError(400, "Id parameter is required");

        const result = await clientService.getClient(id);

        return res.status(200).json({
            success:true,
            data: result
        })
    }

    getClients = async(req: Request, res: Response)=>{
        const params: GetAllClientsDto = {
            page: parseInt(req.params.page as string),
            pageLimit: parseInt(req.params.pageLimit as string)
        };
        const result = await clientService.getAllClients(params);

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

    }

}