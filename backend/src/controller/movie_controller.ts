import { Request,Response } from "express";
import dotenv from "dotenv";
import { Movie } from "../model/movie.model";


dotenv.config();
export class MovieController{
   
   
    //Fetch movie based on year


     //Adding Movies 
    static async addMovie(req:Request,res:Response)
    { 

      let   {
            moviename,
            moviedescription,
            movietrailerurl,
            moviethumbnailurl,
            moviecategory,
            movieyear ,
            moviestarcast,
            ismovie,
            showepisodes, } = req.body ;

            let movie = new Movie({
                moviename:moviename,
            moviedescription:moviedescription,
            movietrailerurl:movietrailerurl,
            moviethumbnailurl:moviethumbnailurl,
            moviecategory:moviecategory,
            movieyear:movieyear,
            moviestarcast:moviestarcast,
            ismovie:ismovie,
            showepisodes:showepisodes
            });

            await movie.save().then((data:any)=>{
                return res.send({
                    data:data,
                    submitted:true
                })

            }).catch((error:any)=>{
                return res.send({
                    data:error,
                    submitted:false
                })
            })
    }



     //Fetching Movies 
     static async fetchMovies(req:Request,res:Response){

        try{
            await Movie.find().then((movieData:any)=>{
                return res.send({
                    submitted:false,
                    data:movieData,
                })

            })
        }catch(error){
            return res.send({
                submitted:false,
                data:null,
            })

        }
       

     }


 //Fetch movie based on category
 static async fetchMovieByCategory(req:Request,res:Response){

    let { moviecategory } = req.params;

    try{
        await Movie.find(
            {
                moviecategory:moviecategory,
        },(error:any,movies:any)=>{
            if(error)
            {
                return res.send({
                    submitted:false,
                    data:null,
                })
            }else{
                return res.send({
                    submitted:true,
                    data:movies,
                })
            }
        });
    }catch(error){
        console.log(error)
        return res.send({
            submitted:false,
            data:null,
        })
    }
 }


 //Fetch movie by Year
 static async fetchMoviesByYear(req:Request,res:Response){

    let { movieyear } = req.params;

    try{
        await Movie.find({
            movieyear:movieyear,
        },(error:any,movies:any)=>{
            if(error){
                return res.send({
                    submitted:false,
                    data:null
                })
            }else{
                return res.send({
                    submitted:true,
                    data:movies
                })
            }
        });
    }catch(error){
        console.log(error)
        return res.send({
            submitted:false,
            data:null
        })

    }

 }





}
