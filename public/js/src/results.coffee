source = $("#results-template").html();
dataTemplate = Handlebars.compile(source);


addAnswersToRank = (data) ->

	$.get '/getanswers', data, (answers) ->
		console.log("answeranswer:",answers)
		console.log("data.future",data.future, "data.goals",data.goals)

		$('#resultsRepo').html(dataTemplate(answers))
$ ->

	addAnswersToRank({randomize: false, future: false, goals: false, asc : false, desc : false})


	$(document).on 'click', '.sortAsc', () ->
		addAnswersToRank({randomize: false, future: false, goals: false, asc : true, desc : false})
	$(document).on 'click', '.sortDesc', () ->
		addAnswersToRank({randomize: false, future: false, goals: false, asc : false, desc : true})
