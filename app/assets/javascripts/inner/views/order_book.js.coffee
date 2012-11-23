$(document).ready ->
	sociorent.views.order_book = Backbone.View.extend
		tagName: "div"
		className: "order_book_single"

		template: _.template $("#order_book_template").html()

		initialize: ->
			_.bindAll this, 'render'

		events:
			"click .shipped" : "show_shipping_details"
		
		render: ->
			if @model.get("shipped")
				shipped_button_text = "Shipping details"
				shipped_class = "shipped"
			else
				shipped_button_text = "Not shipped"
				shipped_class = "not_shipped"
			$(@el).html @template
				model: @model.toJSON()
				shipped_class: shipped_class
				shipped_button_text: shipped_button_text
			this

		show_shipping_details: ->
			@$(".order_book_shipping_details").fadeIn 200