import {Request, Response} from "express";
import ApiError from "../../shared/errors/ApiError";
import PetService from "./pet.service";
import {CreatePetDto, PetResponse, UpdatePetDto} from "./pet.types";
import env from "../../config/env"

const petService: PetService = new PetService();

export default class PetController{
    getPet = async(req: Request, res: Response) => {
        const id = req.params.id as string;

        if(!id) throw new ApiError(400, "Pet ID required");

        const result: PetResponse = await petService.getPet(id);

        return res.status(200).json({
            success:true,
            data:result
        })
    }

    searchPets = async(req: Request, res: Response)=>{
        if(!req.query.pageLimit || !req.query.page) throw new ApiError(400, "Invalid Page or Page Limit")
        
        var pageLimit = Math.min(
            parseInt(req.query.pageLimit as string),
            env.constants.max_page_limit_pets
        );
        var page = parseInt(req.query.page as string)

        pageLimit = Math.min()

        const result = await petService.searchAllPets({
            page,
            pageLimit
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