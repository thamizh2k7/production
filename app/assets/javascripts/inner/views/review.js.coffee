$(document).ready ->
	sociorent.views.review = Backbone.View.extend
		tagName: "div"
		className: "review_single"

		template: _.template $("#review_template").html()

		initialize: ->
			_.bindAll this, 'render'

		render: ->
			$(@el).html @template(@model.toJSON())
			this