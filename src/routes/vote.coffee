mongoose = require('mongoose');

GlobalAnswer = require('./../Models/answers')
user = require('./../Models/User')

# req { age: '12-17', country: 'wrg', ethnicity: 'wrg', gender: 'wgr' }
exports.upvote = (req,res) -> 

	# update global votes
	console.log(req.query.otherId)
	GlobalAnswer.findByIdAndUpdate req.query.chosenId, {$inc: { votes: 1 }}, (err, data) ->
		console.log("data",data);
		if(err) 
			throw err;
		else
		# update the optionsSeen
			userName = req.user.name
			chosenId = req.query.chosenId
			otherId = req.query.otherId
			user.find {name: userName}, (err, userData) ->
				if(err)
					throw err
				
				else if userData[0].optionsSeen
					user.findOneAndUpdate {name: "#{req.user.name}"}, {$pushAll: {optionsSeen: [chosenId,otherId]}}, (err, data) ->
						if err
							throw err
						console.log("data",data)
						res.send({success: "success"})
				else
					console.log('no array')
					user.find {name: "#{req.user.name}"}, (data,err) ->
						data[0].save({optionsSeen: [req.query.chosenId, req.query.otherId]})
						if(err) 
							throw err;
						res.send({success: "success"})

