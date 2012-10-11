$(document).ready ->
	sociorent.views.compare = Backbone.View.extend
		tagName: "div"
		className: "compare_single"

		template: _.template $("#compare_template").html()

		initialize: ->
			_.bindAll this, 'render', 'remove_from_compare'

		events: 
			"click .remove_from_compare" : "remove_from_compare"
			"click" : "open_dialog"

		remove_from_compare: ->
			sociorent.collections.compare_object.remove @model.id
			sociorent.fn.renderCompare()
			false

		open_dialog: ->
			view = new sociorent.views.book_details
				model: @model
			$("#book_details_box").html view.render().el
			if sociorent.collections.cart_object.get(@model.id)
				$(".book_details .add_to_cart").html "In Your Cart"
			$("#book_details_box").dialog("open")


		render: ->
			$(@el).html @template(@model.toJSON())
			this