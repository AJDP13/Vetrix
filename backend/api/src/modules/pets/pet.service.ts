import ApiError from "../../shared/errors/ApiError";
import {CreatePetDto, GetAllPetsDto, PetResponse, UpdatePetDto} from "./pet.types";
import Pet from "./pet.model";
import {buildPetResponse} from "./pet.mapper";
import Client from "../clients/client.model";
import Prescription, {PrescriptionState} from "../prescriptions/prescription.model";
import {Op} from "sequelize";

export default class PetService{
    async createPet(data: CreatePetDto): Promise<PetResponse>{
        const owner = await Client.findByPk(data.owner_id);

        if(!owner) throw new ApiError(404, "Client ID not found");
        
        const pet = await Pet.create({
            name: data.name,
            date_of_birth: data.dob,
            owner_id: owner.id
        })

        if(!pet) throw new ApiError(500, "Error when creating new pet");

        await pet.reload({
            include:[{
                model: Client,
                as: "owner"
            }]
        })

        return buildPetResponse(pet);
    }

    async getAllPets(data: GetAllPetsDto): Promise<PetResponse[]>{
        const pets = await Pet.findAll({
            offset: (data.page-1) * data.pageLimit,
            limit: data.pageLimit
        });

        return pets.map(buildPetResponse);
    }

    async getPet(pet_id: string): Promise<PetResponse>{
        const pet = await Pet.scope("withOwner").findByPk(pet_id);

        if(!pet) throw new ApiError(404, "Pet ID not found");

        return buildPetResponse(pet);
    }

    async updatePet(data: UpdatePetDto): Promise<PetResponse>{
        const pet = await Pet.findByPk(data.id);

        if(!pet) throw new ApiError(404, "Pet ID not found");

        if(data.name) pet.name = data.name;
        // if(data.dob) pet.date_of_birth = data.dob.toString();

        await pet.save();
        await pet.reload();

        return buildPetResponse(pet);
    }

    async archivePet(pet_id: string): Promise<void>{
        const pet = await Pet.findByPk(pet_id);

        if(!pet) throw new ApiError(404, "Pet ID not found");
        const prescriptionCount = await Prescription.count({
            where:{
                pet_id: pet.id,
                expires_at:{
                    [Op.gt]: new Date()
                },
                state:{
                    [Op.ne]: PrescriptionState.VOID
                }
            }
        });

        if(prescriptionCount > 0) throw new ApiError(400, "Pet still has active or draft prescriptions");

        await pet.destroy();

        return;
    }
}