const mongoose = require('mongoose');

mongoose.Promise = global.Promise;

const UserSchema = new mongoose.Schema({
	username: String,
	password: String
});

module.exports = mongoose.model('User', UserSchema);
