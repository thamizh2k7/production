sociorent.collections.cart = Backbone.Collection.extend
	model: sociorent.models.cart

	initialize: ->
		@on "add", ()->
			# listen to add to cart
			$("#cart_button span").html "(" + @models.length + ")"
			$("#no_item_in_cart").hide()
			$("#cart_options_right").show()
			$("#cart_total span").html sociorent.fn.calculate_cart_total()

		@on "remove", ()->
			# listen to remove from cart
			$("#cart_button span").html "(" + @models.length + ")"
			if @models.length == 0
				$("#no_item_in_cart").show()
				$("#cart_options_right").hide()
			sociorent.fn.renderSearch()
			$("#cart_total span").html sociorent.fn.calculate_cart_total()
  
		@on "reset", ()->
			# listen to add to cart
			$("#cart_button span").html "(" + @models.length + ")"
			if @models.length == 0
				$("#no_item_in_cart").show()
				$("#cart_options_right").hide()
			else
				$("#no_item_in_cart").hide()
				$("#cart_options_right").show()
			$("#cart_total span").html sociorent.fn.calculate_cart_total()

sociorent.fn.calculate_cart_total = ()->
	total = 0
	_.each sociorent.collections.cart_object.models, (model)->
		total += model.get("price")
	total