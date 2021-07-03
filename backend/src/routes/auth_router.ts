import Router from "express";
import { AuthController } from "../controller/auth_controller";

const authrouter = Router();

//@get

//@post
//=>Verification Email
authrouter.post("/send-emial-verification",AuthController.sendEmailVerification)
//=>Verify Email
authrouter.post("/verify-email",AuthController.verifyEmail)
//Save Data
authrouter.post("/save-data",AuthController.saveData)

//User Login Path 
authrouter.post("/login",AuthController.login)

export { authrouter};