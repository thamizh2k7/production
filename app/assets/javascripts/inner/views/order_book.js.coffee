$(document).ready ->
	sociorent.views.order_book = Backbone.View.extend
		tagName: "div"
		className: "order_book_single"

		template: _.template $("#order_book_template").html()

		initialize: ->
			_.bindAll this, 'render'
		
		render: ->
			$(@el).html @template(@model.toJSON())
			this