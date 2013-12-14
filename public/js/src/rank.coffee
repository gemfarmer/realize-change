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
		# get vote ID and send to server
	$(document).on 'click',".vote", (e) ->
		e.preventDefault()	
		currentId = $(this).data('id');
		$.get "/upvote",{currentId:currentId},(err,data) ->
			console.log(data)






		
	