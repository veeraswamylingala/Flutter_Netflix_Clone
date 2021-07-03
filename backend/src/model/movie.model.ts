
import mongoose,{Document,Schema} from "mongoose";

//moviename,
//moviedescription
//trailerurl
//thumbnailurl
//movieCategory
//movieyear
//moviestarcast
//ismovie
//

interface MovieInterface extends Document{

    moviename: string;
    moviedescription: string ;
    movietrailerurl: string ;
    moviethumbnailurl: string;
    moviecategory: string ;
    movieyear : string;
    moviestarcast: [string];
    ismovie:boolean;
    showepisodes:[
        {
            showepisodename:string;
            showepisodedescription:string;
            showepisodethumbnail:string;
            showepisodetrailerurl:string;
        }
    ] 
}

const MovieSchema: Schema = new Schema({

    moviename: {type: String, require: true},
    moviedescription: {type: String, require: true},
    movietrailerurl: {type: String, require: true},
    moviethumbnailurl:  {type: String, require: true},
    moviecategory:  {type: String, require: true},
    movieyear : {type: String, require: true},
    moviestarcast: {type: [String], require: true},
    ismovie: {type: Boolean, require: true},
    showepisodes: {type: [Object], require: false},

  });

  const Movie = mongoose.model<MovieInterface>("Movie",MovieSchema);

  export { Movie } ; 