import {ClientResponse} from "../clients/client.types";

export interface CreatePetDto{
    name: string;
    dob: Date;
    owner_id:string;
}

export interface PetResponse{
    id: string;
    name: string;
    dob: Date;
    age_string: string;

    owner: ClientResponse;

    archived: boolean;
}

export interface UpdatePetDto{
    id: string;
    name?: string;
    dob?: string;
}

export interface SearchPetsDto{
    page: number;
    pageLimit: number;

    search?: string;
}