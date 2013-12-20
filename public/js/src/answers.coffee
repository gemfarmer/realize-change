
	


$ ->
	$('#goalsAlert').hide()
	$('#futureAlert').hide()
	$seeAnswers = $('#seeAnswers')
	$seeAnswers.css({opacity: "0"})
	$answers = $('#answers')
	$answerRepo = $('#answerRepo')
	$answerPrompt = $("#answerPrompt")



	$(document).on 'click', '#addAnswer', (e) ->
		e.preventDefault()
		val = $('#answerPrompt').serialize()

		# countryOfOrigin = geoplugin_countryName()
		# console.log countryOfOrigin
		if $('#answerFuture').val() and $('#answerGoals').val()

			$answers.hide()
			$answerRepo.append('<div class="container"><div class="jumbotron row"><h3>Thanks for your participation!</h3><a href="/auth/google">Login</a><span> to check out other people\'s </span><a href="/seeanswers">dreams</a></div></div>')
			
			$.get '/sendanswer', val, (data) ->
			console.log(data)

		else if $('#answerFuture').val()
			$('#goalsAlert').show()
			
		else if $('#answerGoals').val()
			$('#futureAlert').show()
		else
			$('#futureAlert').show()
			$('#goalsAlert').show()


<<<<<<< HEAD
	# $clear = $('#clearAnswer')
	# $clearAnswer.on 'click', (e) ->
	# 	e.preventDefault()
	# 	$("#answerPrompt")[0].reset()
=======
	$clear = $('#clearAnswer')
	$clearAnswer.on 'click', (e) ->
		e.preventDefault()
		$("#answerPrompt").reset()
>>>>>>> 64b4155252376513f16834f93021e921f6326e7f


	$answerFuture = $('#answerFuture')
	$answerGoals = $('#answerGoals')
	$answerFuture.on 'keyup', (e) ->
		e.preventDefault()
		val = $answerFuture.val()
		console.log(val.length)
		$countdownFuture = $('#countdownFuture')
		$countdownFuture.val(250-val.length)
		
		
	$answerGoals.on 'keyup', (e) ->
		e.preventDefault()
		val = $answerGoals.val()
		console.log(val.length)
		$countdownGoals = $('#countdownGoals')
		$countdownGoals.val(150-val.length)
	





