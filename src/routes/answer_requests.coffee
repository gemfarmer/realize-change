mongoose = require('mongoose');

GlobalAnswer = require('./../models/answers')
user = require('./../models/user')
passport = require('passport')
request = require 'request'
_ = require 'underscore'
# user = mongoose.model('User')
# GlobalAnswer = mongoose.model('GlobalAnswer')
# sort by multiple properties     
(->
		sb = (f) ->
				i = @length
				while i
						o = this[--i]
						this[i] = [].concat(f.call(o, o, i), o)
				@sort (a, b) ->
						i = 0
						len = a.length

						while i < len
								return (if a[i] < b[i] then -1 else 1)  unless a[i] is b[i]
								++i
						0
				i = @length
				while i
						this[--i] = this[i][this[i].length - 1]
				this
		if typeof Object.defineProperty is "function"
				try
						Object.defineProperty Array::, "sortBy",
								value: sb
		Array::sortBy = sb  unless Array::sortBy
)()

# module.exports = (GlobalAnswer, app, user) ->
# answers to initial question
exports.sendanswer = (req, res) ->

	# # location data function

				

	console.log("answerquery", req.query)

	# update global answers
	newGlobalAnswer = new GlobalAnswer()

	newGlobalAnswer.answerFuture = req.query.answerFuture
	newGlobalAnswer.answerGoals = req.query.answerGoals
	newGlobalAnswer.date = new Date()
	newGlobalAnswer.ip = req.headers['x-forwarded-for'] or req.connection.remoteAddress
	# newGlobalAnswer.location = getIP(newGlobalAnswer.ip)
	newGlobalAnswer.save (err) ->
		if(err) 
			throw err;

	#Add user answer
	if req.user
		user.find {_id: "#{req.user._id}"}, (err, userToUpdate) ->
			ip = req.headers['x-forwarded-for'] or req.connection.remoteAddress
			userToUpdate[0].update {answers:{answerFuture: req.query.answerFuture, answerGoals: req.query.answerGoals}}, (err) ->
				if(err) 
					throw err;
				res.send({success: "success"})
	else
		console.log("else")
		newUser = new user()
		newUser.ip = req.headers['x-forwarded-for'] or req.connection.remoteAddress

		# getIP = (ip, location) ->
		# 	url = 'http://freegeoip.net/json/' + ip
		# 	request.get url, (error, response, body) ->
		# 		if !error and response.statusCode == 200
		# 			console.log("location",data, typeof(data))
		# 			return data = JSON.parse body
		# getIP(newUser.ip, location)
		newDate = new Date()
		newUser.date = newDate
		# location data
		# newUser.location = getIP(newUser.ip)
		newUser.answers = {
			answerFuture : req.query.answerFuture
			answerGoals: req.query.answerGoals
		}
		console.log(newUser)
		newUser.save (err) ->
			if(err) 
				throw err;
			
			console.log("New user, " + newUser.name + ", was created", newUser.answers);

			res.send({success: "success"})


#instantiate shuffled answers. Used on seeanswers page
shuffledDreams = []
shuffledGoals = []

# get answers from database
exports.getanswers = (req,res) ->
	# console.log("body", req.body)
	console.log("query", req.query)

	
	sortAsc = () ->
		console.log 'asc'
		GlobalAnswer.find {}, (err, results) ->
			sortedResults = results.sortBy () ->
				return [this.votes]
			console.log 'sorted', sortedResults
			res.send {answers: sortedResults}

	sortDesc = () ->
		console.log 'desc'
		GlobalAnswer.find {}, (err, results) ->
			sortedResults = results.sortBy () ->
				return [-this.votes]
			console.log 'sorted', sortedResults
			res.send {answers: sortedResults}


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

			res.send {answers: [choice[randOne],choice[randTwo]], filterNone: true}
		
		# Commented OUt --- Get rid of ranked duplication

		# 	sendClientResponse = (choiceOne,choiceTwo) ->
					
		# 		res.send {answers: [choiceOne,choiceTwo], filterNone: true}
		# 	user.find {_id: "#{req.user._id}"}, (err, chosen) ->
				
				
		# 		if chosen[0].optionsSeen[0]
		# 			for option in chosen[0].optionsSeen
						
		# 				if option is choice[randOne]._id.toString() or option is choice[randTwo]._id.toString()
		# 					console.log("match!!!!!!!!!!!")
		# 					randomAnswer()
		# 					return
		# 				else
		# 					choiceOne = choice[randOne]
		# 					choiceTwo = choice[randTwo]
		# 					sendClientResponse(choiceOne,choiceTwo)
		# 		else
		# 			sendClientResponse(choice[randOne], choice[randTwo])

		# return
					
						

								
	# show random result for both questions
	if req.query.randomize is 'true'
		console.log "true"
		randomAnswer()
	# show dreams
	else if req.query.asc is 'true'
		sortAsc()
	else if req.query.desc is 'true'
		sortDesc()
	# See Answers Section
	else if req.query.future is 'true'
		console.log('all dreams')
		
		
		GlobalAnswer.find {}, (err, answers) ->
			console.log("err:", err)
			
			# console.log("answer",answers);
			# Instantiate Vars
			answersToSend = []
			i = 0
			more = true
			arrayLength = req.query.dreamsToShow

			
			if arrayLength is '10'
				console.log "INNNNNNNNN"
				shuffledDreams = _.shuffle(answers)
			else
				shuffledDreams = shuffledDreams
			if answers.length < arrayLength
				arrayLength = answers.length
				more = false
			while i < arrayLength
				answersToSend.push({answerFuture: shuffledDreams[i].answerFuture, filterFuture: "future", more: more})
				i++
			# answersToSendShuffled = _.shuffle(answersToSend)
			console.log("answersToSend",answersToSend, "shuffle", answersToSend)

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
		# Resuls Section
		GlobalAnswer.find {}, (err, answers) ->
			console.log("err:", err)
			console.log("answer",answers);
			shuffledGoals = _.shuffle(answers)
			answersToSend = []
			for answer in shuffledGoals
				answersToSend.push({answerGoals: answer.answerGoals, answerFuture: answer.answerFuture, votes: answer.votes, filterNone: "none"})
			res.send {answers: answersToSend}





