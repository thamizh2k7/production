sociorent.collections.cart = Backbone.Collection.extend
	model: sociorent.models.cart

	initialize: ->
		@on "add", ()->
			# listen to add to cart
			$("#cart_button span").html "(" + @models.length + ")"
			$("#no_item_in_cart").hide()
			$("#cart_options_right").show()

		@on "remove", ()->
			# listen to remove from cart
			$("#cart_button span").html "(" + @models.length + ")"
			if @models.length == 0
				$("#no_item_in_cart").show()
				$("#cart_options_right").hide()
			sociorent.fn.renderSearch()

		@on "reset", ()->
			# listen to add to cart
			$("#cart_button span").html "(" + @models.length + ")"
			if @models.length == 0
				$("#no_item_in_cart").show()
				$("#cart_options_right").hide()
			else
				$("#no_item_in_cart").hide()
				$("#cart_options_right").show()