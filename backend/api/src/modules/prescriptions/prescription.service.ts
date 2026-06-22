import ApiError from "../../shared/errors/ApiError";
import {
    CreatePrescriptionDto,
    GetAllPrescriptionsDto,
    PrescriptionResponse,
    UpdatePrescriptionDto
} from "./prescription.types";
import Prescription from "./prescription.model";
import Pet from "../pets/pet.model";
import {buildPrescriptionResponse} from "./prescription.mapper";

export default class PrescriptionService{
    async createPrescription(data: CreatePrescriptionDto):Promise<PrescriptionResponse>{
        const pet = await Pet.findByPk(data.pet_id);

        if(!pet) throw new ApiError(404, "Pet ID not found");

        const prescription: Prescription = await Prescription.create({
            pet_id: pet.id,
            prescribed_at: data.prescribed_at,
            expires_at: data.expires_at,
            ...(data.max_repeats ? {max_repeats: data.max_repeats} : {}),
            ...(data.repeat_interval_days ? {repeat_interval_days: data.repeat_interval_days} : {}),
            ...(data.prescribed_by ? {prescribed_by: data.prescribed_by} : {}),
            ...(data.prescribing_practice ? {prescribing_practice: data.prescribing_practice} : {}),
            notes: data.notes
        });

        await prescription.reload({
            include: Pet
        });

        return buildPrescriptionResponse(prescription);
    }

    async getAllPrescriptions(data: GetAllPrescriptionsDto):Promise<PrescriptionResponse[]>{

    }

    async getPrescription(id: string):Promise<PrescriptionResponse>{

    }

    async updatePrescription(data: UpdatePrescriptionDto):Promise<PrescriptionResponse>{
    }

    async archivePrescription(id: string):Promise<void>{

    }
}