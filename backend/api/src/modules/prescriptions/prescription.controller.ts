import {Request, Response} from "express";
import ApiError from "../../shared/errors/ApiError";


export default class PrescriptionController {

    getPrescription = async (req: Request, res: Response) => {
        const id = req.params.id as string;

        if (!id) throw new ApiError(400, "Prescription ID required");
    }

    getAllPrescriptions = async (req: Request, res: Response) => {
        const {pageLimit, page} = req.params;

        if (!pageLimit || !page) throw new ApiError(400, "Invalid Page or Page Limit")
    }

    updatePrescription = async (req: Request, res: Response) => {
        const id = req.params.id as string;

        if (!id) throw new ApiError(400, "Prescription ID required");
    }

    createPrescription = async (req: Request, res: Response) => {
    }

    archivePrescription = async (req: Request, res: Response) => {
        const id = req.params.id as string;

        if (!id) throw new ApiError(400, "Prescription ID required");
    }
}