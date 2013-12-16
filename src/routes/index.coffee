# renderObj = { title: app.locals.config.title, subtitle: app.locals.config.subtitle, 200}

paypal = require('paypal-rest-sdk')

exports.index = (req, res) ->
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle});


exports.main = (req, res) ->
	# renderObj.username = req.user.name
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle, username: req.user.name, 200});
	# res.send({login: "success", username: req.user.name}, 200);
	# res.redirect('/')

# exports.partials = (req, res) ->
# 	# console.log("req params",req.params)
# 	renderObj = {}
# 	renderObj.title = app.locals.config.title
# 	renderObj.subtitle =  app.locals.config.subtitle
# 	renderObj.username = req.user.name
# 	renderObj.routeName = req.params.name;

# 	# console.log(name)
# 	res.render("partials/#{req.params.name}", renderObj);
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

#Paypal functions
exports.paypalindex = (req, res) ->
	res.render('paypals/paypalindex')

exports.create = (req, res) ->
	method = req.param('method')

	payment = {
		"intent": "sale",
		"payer": {
		},
		"transactions": [{
			"amount": {
				"currency": req.param('currency'),
				"total": req.param('amount')
			},
			"description": req.param('description')
		}]
	}
	if (method is 'paypal')
		payment.payer.payment_method = 'paypal'
		payment.redirect_urls = {
			"return_url": config.paypal.returnURL,
			"cancel_url": config.paypal.cancelURL
		}
	else if (method is 'credit_card')
		funding_instruments = [
			{
				"credit_card": {
					"type": req.param('type').toLowerCase(),
					"number": req.param('number'),
					"expire_month": req.param('expire_month'),
					"expire_year": req.param('expire_year'),
					"first_name": req.param('first_name'),
					"last_name": req.param('last_name')
				}
			}
		];
		payment.payer.payment_method = 'credit_card'
		payment.payer.funding_instruments = funding_instruments

	paypal.payment.create(payment, (error, payment) ->
		if (error)
			console.log(error)
			res.render('paypals/error', { 'error': error })
		else
			req.session.paymentId = payment.id
			res.render('paypals/create', { 'payment': payment })
	)

exports.execute = (req, res) ->
	paymentId = req.session.paymentId
	payerId = req.param('PayerID')
	details = { "payer_id": payerId };
	payment = paypal.payment.execute(paymentId, details, (error, payment) ->
		if (error)
			console.log(error)
			res.render('paypals/error', { 'error': error })
		else
			res.render('paypals/execute', { 'payment': payment })
	)

exports.cancel = (req, res) ->
	res.render('paypals/cancel')

# Paypal Configuration

exports.init = (c) ->
	config = c
	paypal.configure(c.api)