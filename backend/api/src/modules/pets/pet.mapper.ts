import Pet from "./pet.model";
import {PetResponse} from "./pet.types";
import {buildClientResponse} from "../clients/client.mapper";

export function buildPetResponse(data: Pet): PetResponse{
    const dob = new Date(data.date_of_birth);
    return {
        id: data.id,
        name: data.name,
        dob,
        age_string: "Pet age", //TODO: Update to output correct age in string form

        owner: buildClientResponse(data.owner!)
    }
}