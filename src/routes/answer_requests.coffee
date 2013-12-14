mongoose = require('mongoose');

GlobalAnswer = require('./../Models/answers')
user = require('./../Models/User')


# answers to initial question
exports.sendanswer = (req, res) ->
	# parsedquery = parse(req.query)
	# parsedBody = (req.query).parse()

	console.log("answerquery", req.query)

	# update global answers
	newGlobalAnswer = new GlobalAnswer()

	newGlobalAnswer.answerFuture = req.query.answerFuture
	newGlobalAnswer.answerGoals = req.query.answerGoals
	newGlobalAnswer.save (err) ->
		if(err) 
			throw err;

	# console.log("username",username)
	console.log(req.user.name)

	#Add user answer
	user.find {name: "#{req.user.name}"}, (err, userToUpdate) ->

		userToUpdate[0].update {answers:{answerFuture: req.query.answerFuture, answerGoals: req.query.answerGoals}}, (err) ->
			if(err) 
				throw err;
		res.send({success: "success"})



# get answers from database
exports.getanswers = (req,res) ->
	# console.log("body", req.body)
	console.log("query", req.query)

	
	randomAnswer = () ->
		# Instantiate Rand
		randOne = 0
		randTwo = 0
		# Count total answers
		GlobalAnswer.count {}, (err, num) ->
			# console.log("num",num)
			console.log("err", err)
			randOne = Math.floor(Math.random() * num)
			console.log("first",randOne)
			secondRandom = () ->
				output = Math.floor(Math.random() * num)
				console.log("second", output)
				if output is randOne
					secondRandom()
				else
				
					output
			randTwo = secondRandom()

		GlobalAnswer.find {}, (err, choice) ->
			# console.log("rand", choice[rand])
			console.log({answers: [choice[randOne], choice[randTwo]], filterNone: true})
			res.send {answers: [choice[randOne], choice[randTwo]], filterNone: true}
			
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
	else if req.query.goals is 'true'
		console.log('all dreams')
		GlobalAnswer.find {}, (err, answers) ->
			console.log("err:", err)
			console.log("answer",answers);
			answersToSend = []
			for answer in answers
				answersToSend.push({answerGoals: answer.answerGoals, filterGoals: "goals"})
			res.send {answers: answersToSend}
	else
		GlobalAnswer.find {}, (err, answers) ->
			console.log("err:", err)
			console.log("answer",answers);
			answersToSend = []
			for answer in answers
				answersToSend.push({answerGoals: answer.answerGoals, answerFuture: answer.answerFuture, votes: answer.votes, filterNone: "none"})
			res.send {answers: answersToSend}





			