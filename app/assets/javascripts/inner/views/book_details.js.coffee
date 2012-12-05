$(document).ready ->
	sociorent.views.book_details = Backbone.View.extend
		tagName: "div"
		className: "book_details"

		template: _.template $("#book_details_template").html()

		initialize: ->
			_.bindAll this, 'render', 'add_to_cart'

			that = this
			sociorent.app_events.bind "added_to_cart", (id)->
				if that.model.id == id
					# when this model is added to cart
					that.$(".add_to_cart").html("Added to Cart").css
						background: "#0F8159"

			sociorent.app_events.bind "removed_from_cart", (id)->
				if that.model.id == id
					# when this model is removed from cart
					that.$(".add_to_cart").html("Add to Cart").css
						background: "#F65757"

		events: 
			"click .add_to_cart" : "add_to_cart"
			"click .add_to_wishlist": "add_to_wishlist"
			"submit .reviews_form" : "make_review"
			"click .reviews_caption_right" : "focus_review_input"
			"click .author_names a" : "search_author"

		render: ->
			$(@el).html @template(@model.toJSON())
			if $.inArray(@model.id, sociorent.models.user_object.get("wishlist")) > -1
				@$(".add_to_wishlist").html "Already in your Wishlist."
			if sociorent.collections.cart_object.get(@model.id)
				@$(".add_to_cart").css
					background: "#0F8159"
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
						sociorent.fn.renderCart()

		add_to_wishlist: ->
			if $.inArray(@model.id, sociorent.models.user_object.get("wishlist")) == -1
				that = this
				$.ajax "/users/add_to_wishlist" ,
					type:"post"
					async:true
					data:
						book: that.model.id
					success: (msg)->
						that.$(".add_to_wishlist").html "Added to your Wishlist"
						sociorent.models.user_object.set
							wishlist: msg

		make_review: ->
			that = this
			content = $.trim($(".reviews_input").val())
			if content == ""
				alert "please enter the content of the review"
				false
			else
				$.ajax "/home/make_review" ,
						type:"post"
						async:true
						data:
							book: that.model.id
							content: content
						success: (msg)->
							$(".reviews_form").html("").hide()
							model = new sociorent.models.review msg
							view = new sociorent.views.review
								model: model
							$(".reviews_content").append view.render().el
				false

		focus_review_input: ->
			$(".reviews_input").focus()
			$("#book_details_box").animate({scrollTop: $(".reviews_input")[0].scrollHeight}, 300);

		search_author: (ev)->
			author = $.trim $(ev.target).html()
			$("#book_details_box").dialog("close")
			$("#search_books_input").val(author)
			sociorent.fn.search()
			false