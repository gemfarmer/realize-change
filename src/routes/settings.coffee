mongoose = require('mongoose');

GlobalAnswer = require('./../Models/answers')
user = require('./../Models/User')

# req { age: '12-17', country: 'wrg', ethnicity: 'wrg', gender: 'wgr' }
exports.newsettings= (req,res) -> 
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
