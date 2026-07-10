import {Request, Response} from "express";
import ApiError from "../../shared/errors/ApiError";
import PrescriptionService from "./prescription.service";
import {
    CreatePrescriptionDto,
    SearchPrescriptionsDto,
    PrescriptionResponse,
    UpdatePrescriptionDto
} from "./prescription.types";
import env from "../../config/env"

const prescriptionService: PrescriptionService = new PrescriptionService();

export default class PrescriptionController {

    getPrescription = async (req: Request, res: Response) => {
        const id = req.params.id as string;

        if (!id) throw new ApiError(400, "Prescription ID required");

        const result: PrescriptionResponse = await prescriptionService.getPrescription(id.toLowerCase());

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    searchPrescriptions = async (req: Request, res: Response) => {
        if(!req.query.pageLimit || !req.query.page) throw new ApiError(400, "Invalid Page or Page Limit")
        
        var pageLimit = Math.min(
            parseInt(req.query.pageLimit as string),
            env.constants.max_page_limit_prescriptions
        );
        var page = parseInt(req.query.page as string)

        const data: SearchPrescriptionsDto = {
            pageLimit,
            page
        };

        const result = await prescriptionService.searchPrescriptions(data);

        return res.status(200).json({
            success:true,
            data: result
        })
    }

    updatePrescription = async (req: Request, res: Response) => {
        const id = req.params.id as string;

        if (!id) throw new ApiError(400, "Prescription ID required");

        const data: UpdatePrescriptionDto = req.body;

        const result: PrescriptionResponse = await prescriptionService.updatePrescription(data);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    createPrescription = async (req: Request, res: Response) => {
        var data: CreatePrescriptionDto = req.body;

        data.pet_id = data.pet_id.toLowerCase()

        const result: PrescriptionResponse = await prescriptionService.createPrescription(data);

        return res.status(201).json({
            success:true,
            data: result
        });
    }

    archivePrescription = async (req: Request, res: Response) => {
        const id = req.params.id as string;

        if (!id) throw new ApiError(400, "Prescription ID required");

        await prescriptionService.archivePrescription(id);

        return res.status(204).json({
            success:true
        })
    }
}