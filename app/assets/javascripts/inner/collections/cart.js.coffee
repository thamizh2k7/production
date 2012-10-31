sociorent.collections.cart = Backbone.Collection.extend
	model: sociorent.models.cart

	initialize: ->
		@on "add", (model)->
			# listen to add to cart
			$("#cart_button span").html "(" + @models.length + ")"
			$("#no_item_in_cart").hide()
			$("#cart_options_right").show()
			$("#cart_total span").html sociorent.fn.calculate_cart_total()
			$("#cart_rental_total span").html sociorent.fn.calculate_cart_rental_total()
			# trigger that something has been added to cart
			sociorent.app_events.trigger "added_to_cart", model.id

		@on "remove", (model)->
			# listen to remove from cart
			$("#cart_button span").html "(" + @models.length + ")"
			if @models.length == 0
				$("#no_item_in_cart").show()
				$("#cart_options_right").hide()
			$("#cart_total span").html sociorent.fn.calculate_cart_total()
			$("#cart_rental_total span").html sociorent.fn.calculate_cart_rental_total()
			# trigger that something has been removed from cart
			sociorent.app_events.trigger "removed_from_cart", model.id
  
		@on "reset", ()->
			# listen to add to cart
			$("#cart_button span").html "(" + @models.length + ")"
			if @models.length == 0
				$("#no_item_in_cart").show()
				$("#cart_options_right").hide()
			$("#cart_total span").html sociorent.fn.calculate_cart_total()
			$("#cart_rental_total span").html sociorent.fn.calculate_cart_rental_total()

sociorent.fn.calculate_cart_total = ()->
	total = 0
	_.each sociorent.collections.cart_object.models, (model)->
		total += model.get("price")
	total

sociorent.fn.calculate_cart_rental_total = ()->
	total = 0
	_.each sociorent.collections.cart_object.models, (model)->
		console.log model
		total += (model.get("price")*model.get("publisher").rental)/100
	total