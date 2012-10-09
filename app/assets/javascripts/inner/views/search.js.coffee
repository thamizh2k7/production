$(document).ready ->
	sociorent.views.search = Backbone.View.extend
		tagName: "div"
		className: "search_books_single"

		template: _.template $("#search_template").html()

		initialize: ->
			_.bindAll this, 'render', 'add_to_cart', 'details'

		events:
			"click .add_to_cart" : "add_to_cart"
			"change .add_to_compare": "add_to_compare"
			"click" : "details"

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
			false

		add_to_compare: (ev)->
			checkbox = $(ev.target)
			unless checkbox.attr "checked"
				sociorent.collections.compare_object.remove @model.id
			else
				sociorent.collections.compare_object.add @model.attributes
			sociorent.fn.renderCompare()

		details: (ev)->
			unless $(ev.target).parent().attr("class") == "add_to_compare_box"
				view = new sociorent.views.book_details
					model: @model
				$("#book_details_box").html view.render().el
				if sociorent.collections.cart_object.get(@model.id)
					$(".book_details .add_to_cart").html "In Your Cart"
				$("#book_details_box").dialog("open")

		render: ->
			image = @model.get("book_image")
			if sociorent.collections.cart_object.get(@model.id)
				cart_message = "In Your Cart"
			else
				cart_message = "Add to Cart"
			$(@el).html @template
				id: @model.id
				image: image
				name: @model.get "name"
				author: @model.get "author"
				isbn: @model.get "isbn10"
				cart_message: cart_message
			this