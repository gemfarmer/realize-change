mongoose = require('mongoose');

GlobalAnswer = require('./../Models/User').GlobalAnswerSchema;
GlobalQuestion = require('./../Models/User').GlobalQuestionSchema;


# answers to initial question
exports.sendanswer = (req, res) ->
	# parsedquery = parse(req.query)
	# parsedBody = (req.query).parse()

	console.log("answerquery", req.query)
	newGlobalAnswer = new GlobalAnswer()

	newGlobalAnswer.answerFuture = req.query.answerFuture
	newGlobalAnswer.answerGoals = req.query.answerGoals
	newGlobalAnswer.save (err) ->
		if(err) 
			throw err;
	res.send({success: "success"})

# get answers from database
exports.getanswers = (req,res) ->
	# console.log("body", req.body)
	console.log("query", req.query)

	
	randomAnswer = () ->
		# Instantiate Rand
		rand = 0

		# Count total answers
		GlobalAnswer.count {}, (err, num) ->
			# console.log("num",num)
			console.log("err", err)
			rand = Math.floor(Math.random() * num);
		# Find Random Answer
		GlobalAnswer.find {}, (err, choice) ->
			# console.log("CHOICE",choice)
			# console.log("rand", choice[rand])
			res.send {answers: [choice[rand]], filterNone: true}
	# show random result for both questions
	if req.query.randomize is 'true'
		randomAnswer()
	# show dreams
	else if req.query.future is 'true'
		console.log('all dreams')
		GlobalAnswer.find {}, (err, answers) ->
			console.log("err:", err)
			console.log("answer",answers);
			answersToSend = []
			for answer in answers
				answersToSend.push({answerFuture: answer.answerFuture, filterFuture: "future"})
			res.send {answers: answersToSend}




			