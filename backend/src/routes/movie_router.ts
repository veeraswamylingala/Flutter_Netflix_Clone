import Router from "express";
import { MovieController } from "../controller/movie_controller";

const movierouter = Router();

//Add Movies
movierouter.post("/add-movies",MovieController.addMovie)

//Fetch Movies 
movierouter.get("/fetch-movies",MovieController.fetchMovies)

//fetch movies based on Category 
movierouter.get("/category/:moviecategory",MovieController.fetchMovieByCategory)

//fetch movies based on year
movierouter.get("/year/:movieyear",MovieController.fetchMoviesByYear)


export { movierouter};