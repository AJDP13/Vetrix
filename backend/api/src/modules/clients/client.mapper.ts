import Client from "./client.model";
import {ClientResponse} from "./client.types";

export function buildClientResponse(data: Client): ClientResponse{
    const resp: ClientResponse = {
        id: data.id,
        first_name: data.first_name,
        last_name: data.last_name,
        email: data.email,
        phone: data.phone
    };

    return resp;
}