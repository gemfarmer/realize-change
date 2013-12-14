mongoose = require('mongoose');

GlobalAnswerSchema = new mongoose.Schema({
	answerFuture: String
	answerGoals: String
	votes: Number
});
 


module.exports = mongoose.model('GlobalAnswer', GlobalAnswerSchema)
