import ApiError from "./ApiError";

export default class ValidationError extends ApiError {
    constructor (message = "Validation Failed"){
        super(400, message);
    }
}