
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
		val = $('#answerPrompt').serialize()
		$('#answerFuture').val('')
		$('#answerGoals').val('')

		$.get '/sendanswer', val, (data) ->
			$seeAnswers.css({opacity: "1"})
			$('#success').addClass("show")

			`setTimeout(function() { $("#success").removeClass("show"); }, 3000 );`

