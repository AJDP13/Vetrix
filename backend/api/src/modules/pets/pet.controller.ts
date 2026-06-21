import {Request, Response} from "express";
import ApiError from "../../shared/errors/ApiError";
import PetService from "./pet.service";
import {CreatePetDto, PetResponse, UpdatePetDto} from "./pet.types";

const petService: PetService = new PetService();

export default class PetController{
    searchPets = async(req: Request, res: Response)=>{
    }

    getPet = async(req: Request, res: Response) => {
        const id = req.params.id as string;

        if(!id) throw new ApiError(400, "Pet ID required");

        const result: PetResponse = await petService.getPet(id);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    getPets = async(req: Request, res: Response)=>{
        const {pageLimit, page} = req.params;

        if(!pageLimit || !page) throw new ApiError(400, "Invalid Page or Page Limit")

        const result = await petService.getAllPets({
            page: parseInt(page as string),
            pageLimit: parseInt(pageLimit as string)
        });

        return res.status(200).json({
            success:true,
            data:result
        })

    }

    updatePet = async(req: Request, res: Response) => {
        const id = req.params.id as string;

        if(!id) throw new ApiError(400, "Pet ID required");

        const data: UpdatePetDto = {
            id,
            ...req.body
        }

        const result = await petService.updatePet(data);

        return res.status(200).json({
            success:true,
            data: result
        })
    }

    createPet = async(req: Request, res:Response) => {
        const data: CreatePetDto = req.body;

        const result: PetResponse = await petService.createPet(data);

        return res.status(201).json({
            success:true,
            data:result
        })
    }

    archivePet = async(req: Request, res: Response) => {
        const id = req.params.id as string;

        if(!id) throw new ApiError(400, "Pet ID required");

        await petService.archivePet(id);

        return res.status(200).json({
            success:true
        })
    }

}