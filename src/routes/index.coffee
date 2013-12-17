# renderObj = { title: app.locals.config.title, subtitle: app.locals.config.subtitle, 200}


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
	renderObj.apikey = 'AIzaSyB_e3Hr9YXDi4P4JLX53yZOIr1Osz7L-_U'

	# conditional fixes login 'property name of undefined' error. not permanent
	if req.user is undefined
		res.render("partials/answers", renderObj);
	else
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

