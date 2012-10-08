$(document).ready ->
	sociorent.views.book_details = Backbone.View.extend
		tagName: "div"
		className: "book_details"

		template: _.template $("#book_details_template").html()

		initialize: ->
			_.bindAll this, 'render', 'add_to_cart'


		events: 
			"click .add_to_cart" : "add_to_cart"

		render: ->
			$(@el).html @template(@model.toJSON())
			this

		add_to_cart: ->
			if sociorent.collections.cart_object.get(@model.id)
				false
			else
				that = this
				$.ajax "/home/add_to_cart" ,
					type:"post"
					async:true
					data: 
						book: that.model.id 
					success: (msg)->
						sociorent.collections.cart_object.add msg
						$(that.el).find(".add_to_cart").html "Added to cart"
						sociorent.fn.renderCart()