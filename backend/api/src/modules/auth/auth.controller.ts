import authService from "./auth.service"
import {Request, Response} from "express";

async function register(req, res) {
    const result = await authService.register(req.body);


}