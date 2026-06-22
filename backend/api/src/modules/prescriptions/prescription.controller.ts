import {Request, Response} from "express";
import ApiError from "../../shared/errors/ApiError";
import PrescriptionService from "./prescription.service";
import {
    CreatePrescriptionDto,
    GetAllPrescriptionsDto,
    PrescriptionResponse,
    UpdatePrescriptionDto
} from "./prescription.types";

const prescriptionService: PrescriptionService = new PrescriptionService();

export default class PrescriptionController {

    getPrescription = async (req: Request, res: Response) => {
        const id = req.params.id as string;

        if (!id) throw new ApiError(400, "Prescription ID required");

        const result: PrescriptionResponse = await prescriptionService.getPrescription(id);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    getAllPrescriptions = async (req: Request, res: Response) => {
        const {pageLimit, page} = req.params;

        if (!pageLimit || !page) throw new ApiError(400, "Invalid Page or Page Limit")

        const data: GetAllPrescriptionsDto = {
            pageLimit: parseInt(pageLimit as string),
            page: parseInt(page as string)
        };

        const result = await prescriptionService.getAllPrescriptions(data);

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
        const data: CreatePrescriptionDto = req.body;

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

        return res.status(200).json({
            success:true
        })
    }
}