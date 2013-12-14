$ ->
	$(document).on 'click', '.btn-submit', (e) ->
		e.preventDefault()
		val = $('#demographics').serialize()
		console.log("val",val)
		$.get "/newsettings", val, (err,data) ->
			console.log("data",data)

	