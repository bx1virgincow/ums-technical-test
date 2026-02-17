import { Router } from "express";
import { login } from "../services/authservice/loginService.js";
import registrationService from '../services/authservice/registrationservice.js';


const { register } = registrationService;

const expRoute = Router();
expRoute.route("/login").post(login);
expRoute.route("/register").post(register)

export default { expRoute };
