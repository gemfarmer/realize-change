mongoose = require('mongoose');

GlobalAnswer = require('./../Models/answers')
user = require('./../Models/User')
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
			sendClientResponse = (choiceOne,choiceTwo) ->
					
				# console.log("rand", choice[rand])
				# console.log("res.send",{answers: [choice[randOne], choice[randTwo]], filterNone: true})
				res.send {answers: [choiceOne,choiceTwo], filterNone: true}
			user.find {_id: "#{req.user._id}"}, (err, chosen) ->
				
				# console.log("chosen",chosen[0].optionsSeen)
				# console.log("choice:", choice[randOne], choice[randTwo])
				if chosen[0].optionsSeen[0]
					for option in chosen[0].optionsSeen
						# console.log("option",option, choice[randOne]._id, choice[randTwo]._id)
						# console.log(typeof(option), typeof(choice[randOne]._id.toString()), choice[randOne]._id.toString())
						# console.log("match:", (option == choice[randOne]._id), (option == choice[randTwo]._id))

						if option is choice[randOne]._id.toString() or option is choice[randTwo]._id.toString()
							console.log("match!!!!!!!!!!!")
							randomAnswer()
							return
						else
							choiceOne = choice[randOne]
							choiceTwo = choice[randTwo]
							sendClientResponse(choiceOne,choiceTwo)
				else
					sendClientResponse(choice[randOne], choice[randTwo])

		return
					
						

								
	# show random result for both questions
	if req.query.randomize is 'true'
		console.log "true"
		randomAnswer()
	# show dreams
	else if req.query.asc is 'true'
		sortAsc()
	else if req.query.desc is 'true'
		sortDesc()
	else if req.query.future is 'true'
		console.log('all dreams')
		GlobalAnswer.find {}, (err, answers) ->
			console.log("err:", err)
			
			console.log("answer",answers);
			# Instantiate Vars
			answersToSend = []
			i = 0
			more = true
			arrayLength = req.query.dreamsToShow
			if answers.length < arrayLength
				arrayLength = answers.length
				more = false
			while i < arrayLength
				answersToSend.push({answerFuture: answers[i].answerFuture, filterFuture: "future", more: more})
				i++
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





			