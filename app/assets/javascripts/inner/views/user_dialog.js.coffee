$(document).ready ->
	sociorent.views.user_dialog = Backbone.View.extend
		tagName: "div"
		className: "user"

		template: _.template $("#user_dialog_template").html()

		events: 
			"click .menu" : "highlight_current_menu"

		initialize: ->
			_.bindAll this, 'render'

		highlight_current_menu: (ev)->
			$(".menu").removeClass "active"
			current = ev.target
			$(current).addClass "active"

		render: ->
			$(@el).html @template(@model.toJSON())
			this