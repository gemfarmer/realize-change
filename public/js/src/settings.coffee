$ ->
	loadSettings = () ->
		$.get '/loadsettings', (data,err) ->
			console.log("successful",data)

			$('#age').val("#{data.age}" or "")
			$('#country').val("#{data.country}" or "")
			$('#education').val("#{data.education}" or "")
			$('#ethnicity').val("#{data.ethnicity}" or "")
			$('#gender').val("#{data.gender}" or "")
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

	