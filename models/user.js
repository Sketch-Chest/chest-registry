import mongoose from 'mongoose'
import passportLocalMongoose from 'passport-local-mongoose'

const User = new mongoose.Schema({
  username: String,
  email: String,
  password: String
})

User.plugin(passportLocalMongoose)

export default mongoose.model('User', User)
