module.exports = (GlobalAnswer, app, user) ->

	answer_requests = require './answer_requests'
	sendanswer = app.get('/sendanswer', answer_requests)(GlobalAnswer, app, user).sendanswer
	getanswers = app.get('/getanswers', answer_requests)(GlobalAnswer, app, user).getanswers
	
	return {
		sendanswer: sendanswer
		getanswers: getanswers
	}