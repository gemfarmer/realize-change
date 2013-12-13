source = $("#see-answers-template").html();
dataTemplate = Handlebars.compile(source);


appendAnswers = (data) ->

	$.get '/getanswers', data, (answers) ->
		console.log("answeranswer:",answers)
		console.log("data.future",data.future, "data.goals",data.goals)
		$('#answerRepo').html(dataTemplate(answers))
$ ->

	appendAnswers({randomize: true, future: true, goals: true})
	# Get new data when user clicks 'randomize' button
	$('#randomize').on 'click', (e) ->
		e.preventDefault()
		appendAnswers({randomize: true, future: true, goals: true})
	$('#alldreams').on 'click', (e) ->
		e.preventDefault()
		appendAnswers({randomize: false, future: true, goals: false})
	

		