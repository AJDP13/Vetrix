import Prescription from "./prescription.model";
import {PrescriptionResponse} from "./prescription.types";
import {buildPetResponse} from "../pets/pet.mapper";

export function buildPrescriptionResponse(p: Prescription): PrescriptionResponse{
    const data: PrescriptionResponse = {
        id: p.id,
        pet: buildPetResponse(p.pet),
        prescribed_at: p.prescribed_at,
        expires_at: p.expires_at,
        max_repeats: p.max_repeats,
        repeat_interval_days: p.repeat_interval_days,
        prescribed_by: p.prescribed_by,
        prescribing_practice: p.prescribing_practice,
        notes: p.notes ?? "",
        updated_at: p.updated_at
    };

    return data;
}