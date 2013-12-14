mongoose = require('mongoose');
config = require('../config');

console.log(config);

UserSchema = new mongoose.Schema({
	name: String,
	email: {type: String, lowercase: true }
	answers: { 
		answerFuture: String
		answerGoals: String
		votes: Number
	}

});

module.exports = mongoose.model('User', UserSchema);

