source = $("#results-template").html();
dataTemplate = Handlebars.compile(source);


addAnswersToRank = (data) ->

	$.get '/getanswers', data, (answers) ->
		# console.log("answeranswer:",answers)
		# console.log("data.future",data.future, "data.goals",data.goals, data)

		$('#resultsRepo').html(dataTemplate(answers))
$ ->
	goalsToShow = 10
	addAnswersToRank({randomize: false, future: false, goals: false, asc : false, desc : false, goalsToShow: goalsToShow})


	$(document).on 'click', '.sortAsc', () ->
		addAnswersToRank({randomize: false, future: false, goals: false, asc : true, desc : false, goalsToShow: goalsToShow})
	$(document).on 'click', '.sortDesc', () ->
		addAnswersToRank({randomize: false, future: false, goals: false, asc : false, desc : true, goalsToShow: goalsToShow})

	$(document).on 'click', '#moreResults', () ->
		goalsToShow += 10
		addAnswersToRank({randomize: false, future: false, goals: false, asc : false, desc : false, goalsToShow: goalsToShow})


