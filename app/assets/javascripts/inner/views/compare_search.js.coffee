$(document).ready ->
	sociorent.views.compare_search = Backbone.View.extend
		tagName: "div"
		className: "compare_search_single"

		template: _.template $("#compare_search_template").html()

		initialize: ->
			_.bindAll this, 'render'

		events: ->
			"click" : "add_to_compare"

		render: ->
			$(@el).html @template(@model.toJSON())
			this

		add_to_compare: ->
			unless sociorent.collections.compare_object.get @model.id
				sociorent.collections.compare_object.add @model
				view = new sociorent.views.compare_dialog
					model: @model
				$(view.render().el).insertBefore("#search_to_compare")
			$("#compare_search_result").hide()
			$("#compare_search_input").val("")