
import mongoose,{Document,Schema} from "mongoose";


interface UserInterface extends Document{
    username: string;
    useremail: string;
    userpassword:string
}

const UserSchema: Schema = new Schema({
    username: { type: String, required: true },
    useremail: { type: String, required: true },
    userpassword: { type: String, required: true },
  });

  const User = mongoose.model<UserInterface>("User",UserSchema);

  export { User } ; 