$(document).ready ->
	sociorent.views.wishlist = Backbone.View.extend
		tagName:"div"
		className: "wishlist_single"

		template: _.template $("#wishlist_template").html()

		initialize: ->
			_.bindAll this, 'render', 'add_to_cart'

		events:
			"click .add_to_cart" : "add_to_cart"
			"click .remove_from_wishlist" : "remove_from_wishlist"

		render: ->
			if sociorent.collections.cart_object.get(@model.id)
				cart_message = "In Your Cart"
			else
				cart_message = "Add to Cart"
			$(@el).html @template
				id: @model.id
				book_image: @model.get "book_image"
				name: @model.get "name"
				author: @model.get "author"
				price: @model.get "price"
				cart_message: cart_message
			this

		add_to_cart: ->
			if sociorent.collections.cart_object.get(@model.id)
				false
			else
				sociorent.fn.show_notification()
				that = this
				$.ajax "/home/add_to_cart" ,
					type:"post"
					async:true
					data: 
						book: that.model.id 
					success: (msg)->
						sociorent.fn.hide_notification()
						sociorent.collections.cart_object.add msg
						sociorent.fn.renderCart()
						that.$(".add_to_cart").html "Added to cart."

		remove_from_wishlist: ->
			that = this
			sociorent.fn.show_notification()
			$.ajax "/users/remove_from_wishlist" ,
				type:"post"
				async:true
				data: 
					book: that.model.id 
				success: (msg)->
					sociorent.fn.hide_notification()
					$(that.el).fadeOut "300"