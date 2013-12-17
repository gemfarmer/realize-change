mongoose = require('mongoose');
config = require('../config');

console.log(config);

UserSchema = new mongoose.Schema({
	name: {type: String, default: "Guest"
	email: {type: String, lowercase: true, default: "guest@guest.com" }
	answers: { 
		answerFuture: String
		answerGoals: String
	}
	optionsSeen: [String]
	location: String
	demographics: {
		country: String
		education: String
		ethnicity: String
		age: String
		gender: String
	}

});

module.exports = mongoose.model('User', UserSchema);

