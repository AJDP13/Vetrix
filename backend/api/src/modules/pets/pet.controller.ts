import {Request, Response} from "express";
import ApiError from "../../shared/errors/ApiError";
import PetService from "./pet.service";

const petService: PetService = new PetService();

export default class PetController{
    searchPets = async(req: Request, res: Response)=>{
    }

    getPet = async(req: Request, res: Response) => {
    }

    getPets = async(req: Request, res: Response)=>{
    }

    updatePet = async(req: Request, res: Response) => {
    }

    createPet = async(req: Request, res:Response) => {
    }

    archivePet = async(req: Request, res: Response) => {
    }

}