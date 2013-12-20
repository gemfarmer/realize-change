source = $("#see-answers-template").html();
dataTemplate = Handlebars.compile(source);


appendAnswers = (data) ->
	$answerRepo = $('#answerRepo')
	$.get '/getanswers', data, (answers) ->
		# console.log("answeranswer:",answers)
		# console.log("data.future",data.future, "data.goals",data.goals, "data",data)
		$answerRepo.html(dataTemplate(answers))

$ ->
	dreamsToShow = 10
	$moreDreams=$('#moreDreams')
	appendAnswers({randomize: true, future: true, goals: true})
	# Get new data when user clicks 'randomize' button
	$('#randomize').on 'click', (e) ->
		e.preventDefault()
		appendAnswers({randomize: true, future: true, goals: true})
	$('#alldreams').on 'click', (e) ->
		e.preventDefault()
		$('#splash').prepend('<div class="btn btn-success" id="oneDream">New Dream</div>')
		$('#alldreams').hide()

		$(document).on 'click', '#moreDreams', (e) ->
			dreamsToShow += 10
			e.preventDefault()

			appendAnswers({randomize: false, future: true, goals: false, dreamsToShow: dreamsToShow})
			

		return appendAnswers({randomize: false, future: true, goals: false, dreamsToShow: dreamsToShow})
	$(document).on 'click', '#oneDream', (e) ->
		e.preventDefault()
		$('#alldreams').show()
		$('#oneDream').hide()
		appendAnswers({randomize: true, future: true, goals: true})



# `google.load('visualization', '1', {'packages': ['geochart']});
# google.setOnLoadCallback(drawRegionsMap);

# function drawRegionsMap() {
# 	var data = google.visualization.arrayToDataTable([
# 		['Country', 'Popularity'],
# 		['Germany', 200],
# 		['United States', 300],
# 		['Brazil', 400],
# 		['Canada', 500],
# 		['France', 600],
# 		['RU', 700]
# 	]);

# 	var options = {};

# 	var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
# 	chart.draw(data, options)`