import {ClientResponse, CreateClientDto, SearchAllClientsDto, UpdateClientDto} from "./client.types";
import Client from "./client.model";
import ApiError from "../../shared/errors/ApiError";
import {buildClientResponse} from "./client.mapper";
import { PaginatedResponse } from "../../shared/types/response.types";
import { Op } from "sequelize";

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

    async searchAllClients(data: SearchAllClientsDto): Promise<PaginatedResponse<ClientResponse>>{
        var where_query: any = {}

        if (data.search) {
            where_query[Op.or] = [
                { first_name: { [Op.like]: `%${data.search}%` } },
                { last_name: { [Op.like]: `%${data.search}%` } },
                { email: { [Op.like]: `%${data.search}%` } },
                { phone: { [Op.like]: `%${data.search}%` } },
                { id: { [Op.like]: `%${data.search}%` } },
            ];
        }

        const {rows, count} = await Client.findAndCountAll({
            limit: data.pageLimit,
            offset: data.pageLimit * (data.page-1),
            where: where_query
        });

        const totalPages = Math.ceil(count/data.pageLimit)
        
        return{
            items: rows.map(buildClientResponse),
            total: count,
            page: Math.min(data.page, totalPages),
            pageLimit: data.pageLimit,
            totalPages
        }
    }

    async getClient(client_id: string): Promise<ClientResponse>{
        const client = await Client.findByPk(client_id);

        if(!client) throw new ApiError(404, "Client ID not found");

        return buildClientResponse(client);
    }

    async updateClient(data: UpdateClientDto): Promise<ClientResponse>{
        console.log("Client ID: " + data.id)
        const client = await Client.findByPk(data.id);

        if(!client) throw new ApiError(404, "Client ID not found");

        if(data.first_name!=undefined) client.first_name = data.first_name;
        if(data.last_name!=undefined) client.last_name = data.last_name;
        if(data.phone!=undefined) client.phone = data.phone;
        if(data.email && data.email != client.email){
            const emailFound = await Client.findOne({
                where:{
                    email: data.email
                }
            });

            if(emailFound) throw new ApiError(409, "Email already in use");

            client.email = data.email
        }

        if(data.address_line_1!=undefined) client.address_line_1 = data.address_line_1
        if(data.address_line_2!=undefined) client.address_line_2 = data.address_line_2
        if(data.address_line_3!=undefined) client.address_line_3 = data.address_line_3
        if(data.address_city!=undefined) client.address_city = data.address_city
        if(data.address_postcode!=undefined) client.address_postcode = data.address_postcode

        await client.save();

        await client.reload();

        return buildClientResponse(client);
    }

    async archiveClient(client_id: string): Promise<void>{
        const client = await Client.findByPk(client_id);

        if(!client) throw new ApiError(404, "Client ID not found");

        await client.destroy();

        //In future require that no active pets are under the client

        return;
    }
}