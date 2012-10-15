$(document).ready ->
	sociorent.views.class_adoption = Backbone.View.extend
		tagName: "div"
		className: "class_adoption_single"

		template: _.template $("#class_adoption_template").html()

		initialize: ->
			_.bindAll this, 'render'

		render: ->
			$(@el).html @template(@model.toJSON())
			this