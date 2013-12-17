mongoose = require('mongoose');

GlobalAnswer = require('./../models/answers')
user = require('./../models/user')
# user = mongoose.model('User');

# req { age: '12-17', country: 'wrg', ethnicity: 'wrg', gender: 'wgr' }
exports.newsettings = (req,res) -> 
	user.find {name: "#{req.user.name}"}, (err, userToUpdate) ->

		userToUpdate[0].update {
			demographics: {
				country: req.query.country
				ethnicity: req.query.ethnicity
				age: req.query.age
				gender: req.query.gender
				education: req.query.education
			}
		}, (err) ->

		
			if(err) 
				throw err;
			res.send({success: "success"})
exports.loadsettings = (req,res) ->
	if req.user

		user.find {name: "#{req.user.name}"}, (err, userToLoad) ->
			console.log("user",userToLoad[0].demographics)
			res.send(userToLoad[0].demographics)
	else
		res.send({
				country: ""
				ethnicity: ""
				age: "12-17"
				gender: ""
				education: ""
			})