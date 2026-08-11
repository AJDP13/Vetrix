export interface CreateClientDto{
    first_name: string;
    last_name: string;
    email: string;
    phone: string;
}

export interface ClientResponse{
    id: string;
    first_name: string;
    last_name: string;
    email: string;
    phone: string;

    address_line_1: string;
    address_line_2: string;
    address_line_3: string;
    address_city: string;
    address_postcode: string;

    archived: boolean;
    //pets: Pet[]; //FUTURE
}

export interface SearchAllClientsDto{
    page: number;
    pageLimit: number;

    search?: string;
}

export interface UpdateClientDto{
    id: string;

    first_name?: string;
    last_name?: string;
    email?: string;
    phone?: string;

    address1: string;
    address2: string;
    address3: string;
    addressCity: string;
    addressPostcode: string;
}