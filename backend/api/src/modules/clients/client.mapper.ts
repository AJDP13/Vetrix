import Client from "./client.model";
import {ClientResponse} from "./client.types";

export function buildClientResponse(data: Client): ClientResponse{
    const resp: ClientResponse = {
        id: data.id,
        first_name: data.first_name,
        last_name: data.last_name ?? "",
        email: data.email,
        phone: data.phone ?? "",
        address_line_1: data.address_line_1 ?? "",
        address_line_2: data.address_line_2 ?? "",
        address_line_3: data.address_line_3 ?? "",
        address_city: data.address_city ?? "",
        address_postcode: data.address_postcode ?? "",
        archived: data.deleted_at != null
    };

    return resp;
}