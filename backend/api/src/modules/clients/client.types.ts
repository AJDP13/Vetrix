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

    //pets: []; //FUTURE
}

export interface GetAllClientsDto{
    page: number;
    pageLimit: number;
}

export interface UpdateClientDto{
    id: string;

    first_name?: string;
    last_name?: string;
    email?: string;
    phone?: string;
}