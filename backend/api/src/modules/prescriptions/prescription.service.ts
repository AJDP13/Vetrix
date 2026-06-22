import ApiError from "../../shared/errors/ApiError";
import {
    CreatePrescriptionDto,
    SearchPrescriptionsDto,
    SearchPrescriptionsResponse,
    PrescriptionResponse,
    UpdatePrescriptionDto
} from "./prescription.types";
import Prescription from "./prescription.model";
import Pet from "../pets/pet.model";
import {buildPrescriptionResponse} from "./prescription.mapper";
import Client from "../clients/client.model";

export default class PrescriptionService{
    private async getPrescriptionInternal(id: string): Promise<Prescription>{
        const prescription = await Prescription.findByPk(id);

        if(!prescription) throw new ApiError(404, "Prescription ID not found");

        return prescription;
    }

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
            notes: data.notes,
            state: data.state
        });

        await prescription.reload({
            include: [{
                model: Pet,
                as: "pet",
                include:[{
                    model: Client,
                    as:"owner"
                }]
            }]
        });

        return buildPrescriptionResponse(prescription);
    }

    async searchPrescriptions(data: SearchPrescriptionsDto):Promise<SearchPrescriptionsResponse>{
        const {rows, count} = await Prescription.findAndCountAll({
            limit: data.pageLimit,
            offset: (data.page-1) * data.pageLimit,
            include:[{
                model: Pet,
                as: "pet"
            }],
            order: [["prescribed_at", "DESC"]]
        });

        return {
            prescriptions: rows.map(buildPrescriptionResponse),
            total: count,
            page: data.page,
            pageLimit: data.pageLimit,
            total_pages: Math.ceil(count / data.pageLimit)
        };
    }

    async getPrescription(id: string):Promise<PrescriptionResponse>{
        const prescription = await this.getPrescriptionInternal(id);

        return buildPrescriptionResponse(prescription);
    }

    async updatePrescription(data: UpdatePrescriptionDto):Promise<PrescriptionResponse>{
        const prescription = await this.getPrescriptionInternal(data.id);

        if(data.prescribing_practice) prescription.prescribing_practice = data.prescribing_practice;
        if(data.notes) prescription.notes = data.notes;

        await prescription.save();

        return buildPrescriptionResponse(prescription);
    }

    async archivePrescription(id: string):Promise<void>{
        const prescription = await this.getPrescriptionInternal(id);

        await prescription.destroy();

        return;
    }
}