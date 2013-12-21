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
		# console.log 'asc'
		GlobalAnswer.find {}, (err, results) ->
			sortedResults = results.sortBy () ->
				return [this.votes]
			# console.log 'sorted', sortedResults
			res.send {answers: sortedResults}

	sortDesc = () ->
		# console.log 'desc'
		GlobalAnswer.find {}, (err, results) ->
			sortedResults = results.sortBy () ->
				return [-this.votes]
			# console.log 'sorted', sortedResults
			res.send {answers: sortedResults}


	randomAnswer = () ->
		GlobalAnswer.find {}, (err, choice) ->
			console.log("choice",choice)
			answerIDs = _.map choice, (item) ->
				# console.log("answertype",typeof(item._id))
				return item._id.toString()
			# console.log("answerIDs",answerIDs)
			# console.log("choice", choice)
			user.find {_id: "#{req.user._id}"}, (err, users) ->
				sendClientResponse = (choiceOne,choiceTwo,done) ->
					res.send {answers: [choiceOne,choiceTwo], filterNone: true, done: done}


				# finds values that have not been seen by the user
				differenceArray = _.difference(answerIDs, users[0].optionsSeen)
				# shuffle to randomize
				shuffled = _.shuffle(differenceArray)
				randOne = {}
				randTwo = {}
				for option in choice
					optionString = option._id.toString()
					
					if optionString is shuffled[0]
						randOne = option
					if optionString is shuffled[1]
						randTwo = option
					else 

				# console.log("indexed",indexed)
				if differenceArray.length > 1
					sendClientResponse(randOne, randTwo, false)
				else
					sendClientResponse(randOne, randTwo, true)
			
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
				shuffledDreams = _.shuffle(answers)
			
			if answers.length < arrayLength
				arrayLength = answers.length
				more = false
			while i < arrayLength
				answersToSend.push({answerFuture: shuffledDreams[i].answerFuture, filterFuture: "future", more: more})
				i++
			res.send {answers: answersToSend}
	else if req.query.goals is 'true'
		console.log('all dreams')
		GlobalAnswer.find {}, (err, answers) ->

			answersToSend = []
			for answer in answers
				answersToSend.push({answerGoals: answer.answerGoals, filterGoals: "goals"})
			res.send {answers: answersToSend}
	else
		# Resuls Section
		GlobalAnswer.find {}, (err, answers) ->

			# console.log("answer",answers);
			# shuffledGoals = _.shuffle(answers)
			answersToSend = []

			i = 0
			more = true
			arrayLength = req.query.goalsToShow

			if arrayLength is '10'
				shuffledGoals = _.shuffle(answers)
			if answers.length < arrayLength
				arrayLength = answers.length
				more = false
			while i < arrayLength
				answersToSend.push({answerGoals: shuffledGoals[i].answerGoals, votes: shuffledGoals[i].votes, filterNone: "none", more: more})
				i++
			res.send {answers: answersToSend}





