source = $("#results-template").html();
dataTemplate = Handlebars.compile(source);


addAnswersToRank = (data) ->

	$.get '/getanswers', data, (answers) ->
		console.log("answeranswer:",answers)
		console.log("data.future",data.future, "data.goals",data.goals)
		$('#resultsRepo').html(dataTemplate(answers))
$ ->

	addAnswersToRank({randomize: true, future: true, goals: true})

	