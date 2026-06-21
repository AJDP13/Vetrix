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

    owner: ClientResponse
}

export interface UpdatePetDto{
    id: string;
    name?: string;
    dob?: string;
}

export interface GetAllPetsDto{
    page: number;
    pageLimit: number;
}