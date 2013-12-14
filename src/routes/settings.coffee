mongoose = require('mongoose');

GlobalAnswer = require('./../Models/answers')
user = require('./../Models/User')


exports.newsettings= (req,res) -> 
	console.log("req", req.query);
