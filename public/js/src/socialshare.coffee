$ ->
	$('#shareme').sharrre({
		share: {
			twitter: true,
			facebook: true,
			googlePlus: true
		},
		template: '<div class="box"><div class="left">Share</div><div class="middle"><a href="#" class="facebook">f</a><a href="#" class="twitter">t</a><a href="#" class="googleplus">+1</a></div><div class="right">{total}</div></div>',
		enableHover: false,
		enableTracking: true,
		render: (api, options) ->
			$(api.element).on 'click', '.twitter', () ->
				api.openPopup('twitter');

			$(api.element).on 'click', '.facebook', () ->
				api.openPopup('facebook');

			$(api.element).on 'click', '.googleplus', () ->
				api.openPopup('googlePlus');

	})