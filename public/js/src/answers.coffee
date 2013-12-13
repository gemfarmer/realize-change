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


	# geoCharts
	# console.log("google",google)
	# google.load('visualization', '1', {'packages': ['geochart']});
	# google.setOnLoadCallback(drawRegionsMap);
	# drawRegionsMap = () ->
	# 	data = google.visualization.arrayToDataTable([
	# 		['Country', 'Popularity'],
	# 		['Germany', 200],
	# 		['United States', 300],
	# 		['Brazil', 400],
	# 		['Canada', 500],
	# 		['France', 600],
	# 		['RU', 700]
	# 	]);

	# 	options = {};

	# 	chart = new google.visualization.GeoChart($('#chart_div'));
	# 	chart.draw(data, options);
