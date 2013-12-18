mongoose = require('mongoose');

GlobalAnswerSchema = new mongoose.Schema({
	answerFuture: String
	answerGoals: String
	votes: {type: Number, default: 0}
	date: Object
	ip: String
	location: Object
});
 


module.exports = mongoose.model('GlobalAnswer', GlobalAnswerSchema)
