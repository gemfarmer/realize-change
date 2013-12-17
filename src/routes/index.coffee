mongoose = require('mongoose');
user = require('./../models/user')

exports.index = (req, res) ->
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle});


exports.main = (req, res) ->
	# renderObj.username = req.user.name
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle, username: req.user.name, 200});
	# res.send({login: "success", username: req.user.name}, 200);
	# res.redirect('/')

exports.login = (req,res) ->
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle, username: "login", 200});


exports.answers = (req, res) ->
	req.session.redirectURL = req.url
	renderObj = {}
	renderObj.title = app.locals.config.title
	renderObj.subtitle =  app.locals.config.subtitle

	# conditional fixes login 'property name of undefined' error. not permanent
	console.log("requasdfasdf", req.headers['x-forwarded-for'], req.connection.remoteAddress)
	if req.user is undefined
		user.find {ip: req.headers['x-forwarded-for'] or req.connection.remoteAddress}, (err,data) ->
			console.log("data",data)
			renderObj.answerFuture = data[0].answers.answerFuture
			renderObj.answerGoals = data[0].answers.answerGoals
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
	
	# conditional fixes login 'property name of undefined' error. not permanent
	if req.user is undefined
		res.render("partials/results", renderObj);
	else
		renderObj.username = req.user.name
		res.render("partials/results", renderObj);

exports.mission = (req,res) ->
	req.session.redirectURL = req.url
	console.log("reached mission")
	res.render('partials/mission', { title: app.locals.config.title, subtitle: app.locals.config.subtitle})

exports.cancel = (req, res) ->
  res.send("The payment got canceled")

