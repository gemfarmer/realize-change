source = $("#rank-template").html();
dataTemplate = Handlebars.compile(source);


addAnswersToRank = (data) ->

	$.get '/getanswers', data, (answers) ->
		console.log("answeranswer:",answers)
		console.log("data.future",data.future, "data.goals",data.goals)
		$('#choicesRepo').html(dataTemplate(answers))
$ ->

	addAnswersToRank({randomize: true, future: false, goals: true})

	$('#moreToRank').on 'click', (e) ->
		e.preventDefault()
		addAnswersToRank({randomize: true, future: false, goals: true})
	

		
	