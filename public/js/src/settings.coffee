$ ->
	loadSettings = () ->
		$.get '/loadsettings', (data,err) ->
			console.log("successful",data)
			$('#age').val("#{data.age}")
			$('#country').val("#{data.country}")
			$('#education').val("#{data.education}")
			$('#ethnicity').val("#{data.ethnicity}")
			$('#gender').val("#{data.gender}")
	# Initialize Settings (will be blank initialy)
	loadSettings()



	$(document).on 'click', '.btn-submit', (e) ->
		e.preventDefault()
		val = $('#demographics').serialize()
		console.log("val",val)
		$.get "/newsettings", val, (err,data) ->
			console.log("data",data)
			# Reload settings to dom
			loadSettings()

	