mongoose = require('mongoose');

GlobalAnswer = require('./../Models/answers')
user = require('./../Models/User')

# req { age: '12-17', country: 'wrg', ethnicity: 'wrg', gender: 'wgr' }
exports.upvote = (req,res) -> 

	# update global votes
	GlobalAnswer.findByIdAndUpdate req.query.currentId, {$inc: { votes: 1 }}, (err, data) ->
		console.log("data",data);
		if(err) 
			throw err;
		
		# update the optionsSeen
		user.find {name: "#{req.user.name}"}, (err, data) ->
			if data[0].optionsSeen
				console.log('array')
				user.findOneAndUpdate {name: "#{req.user.name}"}, {$push: {optionsSeen: req.query.currentId}}, (err, data) ->
					if err
						throw err
					res.send({success: "success"})
			else
				console.log('no array')
				user.find {name: "#{req.user.name}"}, (err, data) ->
					data[0].save({optionsSeen: [req.query.currentId]})
					if(err) 
						throw err;
					res.send({success: "success"})

