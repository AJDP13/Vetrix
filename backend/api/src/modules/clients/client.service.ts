import {ClientResponse, CreateClientDto, GetAllClientsDto} from "./client.types";
import Client from "./client.model";
import ApiError from "../../shared/errors/ApiError";
import {buildClientResponse} from "./client.mapper";

export default class ClientService{
    async createClient(data: CreateClientDto): Promise<ClientResponse>{
        const emailFound = await Client.findOne({
            where:{
                email: data.email
            }
        })

        if(emailFound) throw new ApiError(409, "Email already in use");

        const client = await Client.create(
            data
        );

        if(!client) throw new ApiError(500, "Error creating client");

        return buildClientResponse(client);
    }

    async getAllClients(data: GetAllClientsDto): Promise<ClientResponse[]>{
        const clients = await Client.findAll({
            limit: data.pageLimit,
            offset: data.pageLimit * (data.page-1)
        });

        return clients.map(buildClientResponse);
    }

    async getClient(client_id: string): Promise<ClientResponse>{
        const client = await Client.findByPk(client_id);

        if(!client) throw new ApiError(404, "Client ID not found");

        return buildClientResponse(client);
    }
}