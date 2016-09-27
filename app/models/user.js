const mongoose = require('mongoose')

const UserSchema = new mongoose.Schema({
	name: {type: String, default: ''},
	email: {type: String, default: ''},
	hashedPassword: {type: String, default: ''},
	salt: {type: String, default: ''},
	created: Date,
	githubID: String
})

module.exports = mongoose.model('User', UserSchema)
