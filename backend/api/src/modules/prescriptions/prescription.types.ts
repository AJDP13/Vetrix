import {PetResponse} from "../pets/pet.types";
import {PrescriptionState} from "./prescription.model";

export interface CreatePrescriptionDto{
    pet_id: string;
    prescribed_at: Date;
    expires_at: Date;
    max_repeats?: number;
    repeat_interval_days?: number;
    prescribed_by?: string;
    prescribing_practice?: string;
    notes: string|null,
    state: PrescriptionState;
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
    state: PrescriptionState;
}

export interface UpdatePrescriptionDto{
    id: string;
    prescribing_practice: string;
    notes: string;
}

export interface SearchPrescriptionsDto{
    pageLimit: number;
    page: number;

    //V2 - Filters + Sort

    // petId?: string;
    //
    // active?: boolean;
    // expired?: boolean
    //
    // prescribedBy?: string;
    //
    // prescribedAfter?: Date;
    // prescribedBefore?: Date;
    //
    // expiresAfter?: Date;
    // expiresBefore?: Date;
}

export interface SearchPrescriptionsResponse{
    prescriptions: PrescriptionResponse[],
    total: number,
    page: number;
    pageLimit: number;
    total_pages: number;
}