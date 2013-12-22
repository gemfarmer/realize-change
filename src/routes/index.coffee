mongoose = require('mongoose');
user = require('./../models/user')


exports.index = (req, res) ->
	if req.user is undefined
		res.render("index", { title: app.locals.config.title, subtitle: app.locals.config.subtitle});
	else
		res.render("index", { title: app.locals.config.title, subtitle: app.locals.config.subtitle, username: req.user.name});

exports.main = (req, res) ->
	# renderObj.username = req.user.name
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle, username: req.user.name, 200});
	# res.send({login: "success", username: req.user.name}, 200);
	# res.redirect('/')

exports.login = (req,res) ->
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle, username: "login", 200});

# exports.populateDOM = (req, res) ->
# 	seedData = app.locals.initialAnswers
# 	for seed of seedData
# 		newUser = user()
# 		newUser.answerFuture = seed.answerFuture
# 		newUser.answerGoals = seed.answerGoals
# 		newUser.save (err) ->
# 			if err
# 				throw err
# 			sendThatShit()
# 	sendThatShit = () ->
# 		res.send({success: "success"})


exports.answers = (req, res) ->
	req.session.redirectURL = req.url
	renderObj = {}
	renderObj.title = app.locals.config.title
	renderObj.subtitle =  app.locals.config.subtitle
	renderObj.info = app.locals.config.info.answers


	# conditional fixes login 'property name of undefined' error. not permanent
	# console.log("requasdfasdf", req.headers['x-forwarded-for'], req.connection.remoteAddress)
	if req.user is undefined
		user.find {ip: req.headers['x-forwarded-for'] or req.connection.remoteAddress}, (err,data) ->
			if data.toString() isnt ''

				console.log("data",data.toString())
				renderObj.answerFuture = data[0].answers.answerFuture
				renderObj.answerGoals = data[0].answers.answerGoals
				res.render("partials/answers", renderObj);
			else
				res.render("partials/answers", renderObj);
		
	else
		user.find {_id: req.user._id}, (err,data) ->
			console.log("data",data)
			console.log("req",req.user)
			renderObj.answerFuture = data[0].answers.answerFuture
			renderObj.answerGoals = data[0].answers.answerGoals
			renderObj.username = req.user.name
			res.render("partials/answers", renderObj);

exports.seeanswers = (req, res) ->
	req.session.redirectURL = req.url
	renderObj = {}
	renderObj.title = app.locals.config.title
	renderObj.subtitle =  app.locals.config.subtitle
	renderObj.info = app.locals.config.info.seeanswers

	
	# conditional fixes login 'property name of undefined' error. not permanent
	if req.user is undefined
		res.render("partials/seeanswers", renderObj);
	else
		renderObj.username = req.user.name
		res.render("partials/seeanswers", renderObj);
exports.rank = (req, res) ->
	req.session.redirectURL = req.url
	console.log "hey"
	renderObj = {}
	renderObj.title = app.locals.config.title
	renderObj.subtitle =  app.locals.config.subtitle
	renderObj.info = app.locals.config.info.rank
	
	# conditional fixes login 'property name of undefined' error. not permanent
	if req.user is undefined
		res.render("partials/rank", renderObj);
	else
		renderObj.username = req.user.name
		res.render("partials/rank", renderObj);

exports.results = (req, res) ->
	req.session.redirectURL = req.url
	console.log "hey"
	renderObj = {}
	renderObj.title = app.locals.config.title
	renderObj.subtitle =  app.locals.config.subtitle
	renderObj.info = app.locals.config.info.results
	
	# conditional fixes login 'property name of undefined' error. not permanent
	if req.user is undefined
		res.render("partials/results", renderObj);
	else
		renderObj.username = req.user.name
		res.render("partials/results", renderObj);

exports.mission = (req,res) ->
	req.session.redirectURL = req.url
	renderObj = {}
	renderObj.title = app.locals.config.title
	renderObj.subtitle = app.locals.config.subtitle
	renderObj.info = app.locals.config.info.mission
	console.log("reached mission")
	if req.user is undefined
		res.render("partials/mission", renderObj);
	else
		renderObj.username = req.user.name
		res.render("partials/mission", renderObj);


