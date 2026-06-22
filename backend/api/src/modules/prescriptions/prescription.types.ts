import {PetResponse} from "../pets/pet.types";

export interface CreatePrescriptionDto{
    pet_id: string;
    prescribed_at: Date;
    expires_at: Date;
    max_repeats?: number;
    repeat_interval_days?: number;
    prescribed_by?: string;
    prescribing_practice?: string;
    notes: string|null
}

export interface PrescriptionResponse{
    id: string;
    pet: PetResponse;
    prescribed_at: Date;
    expires_at: Date;
    max_repeats: number;
    repeat_interval_days: number;
    prescribed_by: string;
    prescribing_practice: string;
    notes: string;
    updated_at: Date;
}

export interface UpdatePrescriptionDto{
    id: string;
    prescribing_practice: string;
    notes: string;
}

export interface GetAllPrescriptionsDto{
    pageLimit: number;
    page: number;
}