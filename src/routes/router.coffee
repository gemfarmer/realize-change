module.exports = (GlobalAnswer, app) ->

	return {
		sendanswer: require('./sendanswer')(GlobalAnswer, app).sendanswer
		getanswers: require('./getanswers')(GlobalAnswer, app).getanswers
	}
