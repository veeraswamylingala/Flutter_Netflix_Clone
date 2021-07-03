import { Request,Response } from "express";
import randomWords from "random-words";
import nodemailer from "nodemailer";
import dotenv from "dotenv";
import * as EmailValidator   from "email-validator"
import { User } from "../model/user.model";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";



dotenv.config();
export class AuthController{

    //Email Verification
    //=> This function is used to send SecurityCode to  user email 

    static async sendEmailVerification(req: Request ,res: Response){


          //these credential used to send email to userEmail
          let adminanme = process.env.GMAIL_USERNAME as string;
          let adminpassword = process.env.GMAIL_PASSWORD as string;

        //User Entered Email---
        let useremail  = req.body.useremail;

        //this helps in creating randomKey
        let scretKeyword = randomWords();
        console.log(useremail)

      

        //this helps in creating trasport to send email with adminCredentials
      let transporter = nodemailer.createTransport({
          service:"gmail",
          auth:{
              user:adminanme,
              pass:adminpassword
          },
      });

      //the data which you want to send in the email and from to options
      const mailOptions ={
          from :adminanme,
          to : useremail,
          subject:"Netflix Account Verification",
          text:`${scretKeyword} is your Keyword .`
      };

      //this is validate whether the user email is valid or not
      let validateEmail = EmailValidator.validate(useremail)
      console.log(validateEmail)

      if(!validateEmail)
      {
          //Erro rmsg
          return res.send({
              useremail:"Enter valid Email",
              secretcode:null,
              received :false,
          });

      }else{

        User.exists({
            useremail:useremail
        },async(error:any,userExists:any)=>{
            if(error)
            {
                return res.send({
                    useremail:error,
                    secretcode:null,
                    received :false,
                });
                
            }

            if(userExists)
            {
                return res.send({
                    useremail:"Email is already Existed",
                    secretcode:null,
                    received :false,
                });
            }else
            {
          //Sending Email
        transporter.sendMail(mailOptions,(error:any,data:any) =>{
            //If any Network Erros in betwean
            if(error){
                console.log(error);
                return res.send({
                    useremail:"Netwrokr Error",
                    secretcode:null,
                    received :false,
                });

            }
            //sucessfull mail sent
            else{
                let acceptedEmail  = data.accepted;

                if(acceptedEmail.length  != 0)
                {
                    return res.send({
                        useremail:useremail,
                        secretcode:scretKeyword,
                        received :true,
                    });

                }

                if(acceptedEmail.length  == 0)
                {
                    return res.send({
                        useremail:useremail,
                        secretcode:null,
                        received :false,
                    });

                }
            }
        })
            }
        })
      }
        
    }

    //Verify Email
    //Check the SecretCOde with Real Code

    static async verifyEmail(req:Request,res:Response){
        let {secretcode, secretcodeInput,useremail} = req.body;
        console.log(secretcode,secretcodeInput)

        if(secretcode === secretcodeInput)
        {
            return res.send({
            verified:true,
            useremail:useremail
            })

        }else{
            return res.send({
                verified:false,
                useremail:useremail
                })
        }

    }



    //SaveData
    //Saving Data into MongoTanle
    static async saveData(req:Request,res:Response){

        var secretkey = process.env.secretkey as string;

        let{username,useremail,userpassword} = req.body;

        //we are decrypting password usig dcrypt Dependecy
        let salt = await bcrypt.genSalt(10);

        bcrypt.hash(userpassword,salt,async(error:any,hashedPassword:any)=>{
            if(error)
            {
                console.log(error)
                return res.send({
                    authentication:false,
                    data:"Something went Wrong"
                    })

            }
            //once the decrypting Password is success we are creating user 
               const user =   new User({
                    username:username,
                    useremail:useremail,
                    userpassword:hashedPassword
                    });

                //Saving User Dataa
             await user.save().then((val:any) =>{
                        console.log(val);
                        jwt.sign(
                       {
                        useremail:useremail//payload
                        },
                        "secretkey",//secretkey
                        {
                            expiresIn:"1h" //exprireDate
                        },(error:any,tokenData:any) =>{
                            if(error)
                            {
                                console.log(error)
                                return res.send({
                                    authentication:false,
                                    data:"Something went Wrong"
                                    })
                            }else{
                                return res.send({
                                    authentication:true,
                                    data:tokenData
                                    })
                            }
                        }
                        )
                    }).catch((error: any) => {
                        return res.send({
                          data: error,
                          submitted: false,
                        });
                      });

        

        })

    }


    //UserLogin----------
    static async login(req:Request ,res:Response){

        let {useremail,userpassword} = req.body;


        let isValidated = EmailValidator.validate(useremail);

        if(!isValidated)
        {
            return res.send({
                processed:false,
                data:"Invalid Email"
            }) ;
        }


        User.exists(
            {
            useremail:useremail
        }
        ,async(error:any,isExists:any)=>{
            if(error)
            {
                return res.send({
                    processed:false,
                    data:"Invalid Email"
                })

            }else
            {
                console.log(isExists)
                if(!isExists){
                    return res.send({
                        processed:false,
                        data:"No User Found"
                    })
                }else
                {
                    User.findOne({
                        useremail:useremail
                    },async(error:any,userdata:any)=>{
                        if(error)
                        {
                            return res.send({
                                processed:false,
                                data:error
                            })

                        }else{
                            bcrypt.compare(
                                userpassword,
                                userdata.userpassword,(error:any,authentication:any)=>{
                                    if(error)
                                    {
                                        console.log(error)
                                        return res.send({
                                            processed:false,
                                            data:error
                                        })
                                    
                                    }else{

                                        if(!authentication)
                                        {
                                            return res.send({
                                                processed:false,
                                                data:"Wrong Password"
                                            })

                                        }else
                                        {

                                         jwt.sign(
                                            {
                                                useremail:useremail
                                            },
                                            "secretkey",
                                            {
                                                expiresIn: "1h" ,
                                            },
                                            (error:any,tokenData:any) =>{
                                                if(error)
                                                {
                                                    console.log(error)
                                                    return res.send({
                                                        processed:false,
                                                        data:error
                                                    })

                                                }else
                                                {
                                                    return res.send({
                                                        processed:true,
                                                        //data:userdata,
                                                        data:tokenData
                                                    })

                                                }

                                            }
                                            );
                                        
                                        }
                                      
                                    }

                                })

                        }

                    })
                }

            }
        })




    }











}