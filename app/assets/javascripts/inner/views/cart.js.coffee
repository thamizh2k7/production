$(document).ready ->
	sociorent.views.cart = Backbone.View.extend
		tagName: "div"
		className: "cart_single"

		template: _.template $("#cart_template").html()

		initialize: ->
		 	_.bindAll this, 'render', 'remove_book'

		events: 
			"click .cart_delete" : "remove_book"

		render: ->
			$(@el).html @template(@model.toJSON())
			this

		remove_book: ->
			that = this
			$.ajax "/home/remove_from_cart" ,
				type:"post"
				async: true
				data:
					book: that.model.id
				success: (msg)->
					if sociorent.collections.cart_object.get(msg.id)
						sociorent.collections.cart_object.remove(msg.id)
						$(that.el).fadeOut(300)