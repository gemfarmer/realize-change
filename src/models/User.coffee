mongoose = require('mongoose');
config = require('../config');

console.log(config);

UserSchema = new mongoose.Schema({
	name: String
	email: {type: String, lowercase: true }
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

