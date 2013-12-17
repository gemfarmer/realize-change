
	


$ ->
	$('#goalsAlert').hide()
	$('#futureAlert').hide()
	$seeAnswers = $('#seeAnswers')
	$seeAnswers.css({opacity: "0"})
	$answers = $('#answers')
	$answerRepo = $('#answerRepo')
	$answerPrompt = $("#answerPrompt")
	
	# validateForm = (form, name, nameTwo) ->
	# 	form.validate { 
	# 		rules: {
	# 			"#{name}": {
	# 				required: true,
	# 				text: true
	# 			},
	# 			"#{nameTwo}": {
	# 				required: true,
	# 			}
	# 		}
	# 	}
	# validateForm($answerPrompt, answerFuture, answerGoals)
	
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

		
			# $seeAnswers.css({opacity: "1"})
			
			

		
		
			# $('#success').addClass("show")

			# `setTimeout(function() { $("#success").removeClass("show"); }, 3000 );`
	


	$answerFuture = $('#answerFuture')
	$answerGoals = $('#answerGoals')
	$answerFuture.on 'keyup', (e) ->
		e.preventDefault()
		val = $answerFuture.val()
		console.log(val.length)
		$countdownFuture = $('#countdownFuture')
		$countdownFuture.val(300-val.length)
		
		
	$answerGoals.on 'keyup', (e) ->
		e.preventDefault()
		val = $answerGoals.val()
		console.log(val.length)
		$countdownGoals = $('#countdownGoals')
		$countdownGoals.val(150-val.length)
		



