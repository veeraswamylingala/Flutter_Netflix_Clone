import express from "express";
import dotenv from "dotenv";
import mongoose from "mongoose";
import { authrouter } from "./routes/auth_router";
import { movierouter } from "./routes/movie_router";
import cors from "cors";

//Authentication
//=>Email Verification 
//=>Saving Data
//Streaming S3
//Metadata MogoDb

dotenv.config();

const app = express();
app.use(express.json());
app.use(express.urlencoded({extended:false})); 

 const mongodb_url = process.env.MONGODB_URL as string;
const port =  process.env.PORT;
 app.set("port",port);

 //Connecting MonogDb Database using Url
 mongoose.connect(
    mongodb_url,{
    useNewUrlParser: true,
    useCreateIndex: true,
    useUnifiedTopology: true,
    },() => {
        console.log("Database is connected");
    }
 );


 app.use(cors())
//InDirectWay of Writing---y
app.use("/user",authrouter);

app.use("/movie",movierouter);

//Direct way of Writing--
// app.use("/",(req,res)=>{
//     res.send({
//         received:true,
//         data:"this is NetFlick Clone App",
//     });

// });

app.listen(app.get("port"),() => {
    console.log('Server is Runnning  over port'+app.get("port"));
});
