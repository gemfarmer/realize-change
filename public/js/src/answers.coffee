
	# # geoCharts
	# console.log("google",google)
	# drawVisualization = ->
	# 	countries = [["Country", "Popularity"], ["Germany", 200], ["United States", 300], ["Brazil", 400], ["Canada", 500], ["France", 600], ["RU", 700], ["Turkey", 2]]
	# 	data = google.visualization.arrayToDataTable(countries)
	# 	geochart = new google.visualization.GeoChart(document.getElementById("chart_div"))
	# 	options = {}
	# 	geochart.draw data, options
	# google.load "visualization", "1",
	# 	packages: ["geochart"]

	# google.setOnLoadCallback drawVisualization


$ ->
	$seeAnswers = $('#seeAnswers')
	$seeAnswers.css({opacity: "0"})
	$(document).on 'click', '#addAnswer', (e) ->
		e.preventDefault()
		countryOfOrigin = geoplugin_countryName()
		console.log countryOfOrigin

		val = $('#answerPrompt').serialize()
		$('#answerFuture').val('')
		$('#answerGoals').val('')

		$.get '/sendanswer', val, (data) ->
			$seeAnswers.css({opacity: "1"})
			$('#success').addClass("show")

			`setTimeout(function() { $("#success").removeClass("show"); }, 3000 );`
			$('#answers').hide()
			$('#answerRepo').append('<div class="container"><div class="jumbotron row"><h3>Thanks for your participation!</h3><p>Enjoy your dream browsing</p></div></div>')

	$answerFuture = $('#answerFuture')
	$answerGoals = $('#answerGoals')
	$answerFuture.on 'keyup', (e) ->
		e.preventDefault()
		val = $answerFuture.val()
		console.log(val.length)
		$countdownFuture = $('#countdownFuture')
		$countdownFuture.val(500-val.length)
		
		
	$answerGoals.on 'keyup', (e) ->
		e.preventDefault()
		val = $answerGoals.val()
		console.log(val.length)
		$countdownGoals = $('#countdownGoals')
		$countdownGoals.val(200-val.length)
		



