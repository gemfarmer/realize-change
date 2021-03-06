mongoose = require('mongoose');
config = require('../config');

console.log(config);

UserSchema = new mongoose.Schema({
	date: Object
	ip: String
	name: {type: String, default: "Guest"}
	email: {type: String, lowercase: true, default: "guest@guest.com"}
	answers: {answerFuture: String, answerGoals: String	}
	optionsSeen: [String]
	optionsChosen: [String]
	location: Object
	demographics: {
		country: {
			type: String, 
			default: ""
		}
		education: {
			type: String, 
			default: ""
		}
		ethnicity: {
			type: String, 
			default: ""
		}
		age: {
			type: String, 
			default: ""
		}
		gender: {
			type: String, 
			default: ""
		}
	}

});

module.exports = mongoose.model('User', UserSchema);

