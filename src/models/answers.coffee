mongoose = require('mongoose');

GlobalAnswerSchema = new mongoose.Schema({
	answers: {type: [String], user: String}
	answerFuture: String
	answerGoals: String
});
 


exports.GlobalAnswerSchema = mongoose.model('GlobalAnswer', GlobalAnswerSchema)

GlobalQuestionSchema = new mongoose.Schema({
	questions: [String]

});

exports.GlobalQuestionSchema = mongoose.model('GlobalQuestion', GlobalQuestionSchema)