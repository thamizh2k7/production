$(document).ready ->
	sociorent.views.compare_dialog = Backbone.View.extend
		tagName: "div"
		className: "compare_dialog_single"

		template: _.template $("#compare_dialog_template").html()

		initialize: ->
			_.bindAll this, 'render', 'remove_from_compare'

		events: 
			"click .remove_from_compare": "remove_from_compare"

		render: ->
			$(@el).html @template(@model.toJSON())
			this

		remove_from_compare: ->
			sociorent.collections.compare_object.remove @model.id
			sociorent.fn.renderCompare()
			sociorent.fn.renderSearch()
			$(@el).fadeOut(300)