import Joi from "joi";
import {PrescriptionState} from "./prescription.model";

export const createPrescriptionSchema = Joi.object({
    pet_id: Joi.string().required(),
    prescribed_at: Joi.date().required(),
    expires_at: Joi.date().required(),
    max_repeats: Joi.number().min(0).optional(),
    repeat_interval_days: Joi.number().min(0).optional(),
    prescribed_by: Joi.string().optional(),
    prescribing_practice: Joi.string().optional(),
    notes: Joi.string().default(null).optional(),
    state: Joi.string().valid(Object.values(PrescriptionState)).required().default(PrescriptionState.DRAFT)
});

export const updatePrescriptionSchema = Joi.object({
    prescribing_practice: Joi.string().optional(),
    notes: Joi.string().optional()
})