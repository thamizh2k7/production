$(document).ready ->
	sociorent.views.app = Backbone.View.extend
		el: 'body'

		initialize: ->
			# search collection
			sociorent.collections.search_object = new sociorent.collections.search()
			# cart collection
			sociorent.collections.cart_object = new sociorent.collections.cart()
			# compare collection
			sociorent.collections.compare_object = new sociorent.collections.compare()
			# intelligent collections
			sociorent.collections.intelligent_object = new sociorent.collections.intelligent()
			# orders collections
			sociorent.collections.order_object = new sociorent.collections.order()
			# wishlist collections	
			sociorent.collections.wishlist_object = new sociorent.collections.wishlist()
			# class adoption collections
			sociorent.collections.class_adoption_object = new sociorent.collections.class_adoption()
			# review collections
			sociorent.collections.review_object = new sociorent.collections.review()
			# compare search collections
			sociorent.collections.compare_search_object = new sociorent.collections.compare_search()

			# models
			sociorent.models.user_object = new sociorent.models.user()

			# bind scroll of window to this view
			$(window).scroll this.scroll_app
		
		events:
			"submit #search_books_form"	: "cancel_submit"
			"focus #search_books_input" : "expand_search"
			"click #close_search_books" : "shrink_search"
			"submit #request_form" : "make_request"
			"click #cart_button" : "open_cart_dialog"
			"click #cart_options_left" : "close_cart_dialog"
			"click #cart_options_right" : "checkout"
			"click .create_order" : "create_order"
			"click #compare_close" : "compare_close"
			"click #compare_dialog_button" : "compare_dialog"
			"click #compare_button" : "compare_dialog"
			"click #my_account_button" : "open_user_dialog"
			"submit #compare_search_form"	: "cancel_submit"
			"change #ambassador_select" : "select_reference"
			"click #update_shipping" : "update_shipping"

		cancel_submit: ->
			false

		expand_search: ->
			$("#content .left").stop().animate
				width: "50%"
			, 300
			$("#content .right").stop().animate
				width: "49%"
			, 300
			$("#close_search_books").show()

		shrink_search: ->
			$("#content .left").animate
				width: "30%"
			, 300
			$("#content .right").animate
				width: "69%"
			, 300
			$("#close_search_books").hide()

		make_request: ->
			if $.trim($("#request_title").val()) == ""
				$("#request_error").html "Please specify the book title."
				false
			else if ($.trim($("#request_author").val()) == "" && $.trim($("#request_isbn").val()) == "")
				$("#request_error").html "Please specify either the author name or isbn or both."
				false
			else
				$.ajax "/home/book_request" ,
					type: "post" 
					async: true
					data: 
						title: $("#request_title").val()
						author: $("#request_author").val()
						isbn: $("#request_isbn").val()
					success: (msg)->
						$("#request_error").html msg
						$("#request_form").animate({height: "0px"}, 300).html ""
			false

		open_cart_dialog: ->
			$("#cart_box").dialog("open")

		close_cart_dialog: ->
			$("#cart_box").dialog("close")

		update_shipping: ->
			$.post "/update_shipping", $("#shipping_form").serialize(), (resp) ->
				if resp.text is "success"
					$("#shipping_details_box").dialog "close"
					$("#checkout_box").dialog "open"
					sociorent.models.user_object.set($.parseJSON(resp.user))
					view = new sociorent.views.user_dialog
						model: sociorent.models.user_object,
					$("#user_dialog").html(view.render().el)
					$("#profile_address_state").val(sociorent.models.user_object.get("address").address_state)
			false

		checkout: ->
			$("#cart_box").dialog("close")
			$("#shipping_details_box").dialog("open")
			#$("#address_state").val(sociorent.models.user_object.get("address").address_state)
			
		create_order: (event)->
			# get the order type
			order_type = $(event.target).attr "data-attr"
			$.ajax "/orders/create" ,
				type:"post"
				async:true
				data: 
					order_type: order_type
				success: (msg)->
					$("#checkout_box").dialog "close"
					$("#order_box").dialog "open"
					$("#order_id span").html msg.random
					sociorent.collections.order_object.add(msg)
					sociorent.collections.cart_object.reset()
					sociorent.fn.renderSearch()
					sociorent.fn.renderIntelligent()
					sociorent.fn.renderCart()
					$("#profile_orders_button").click()

		compare_close: ->
			sociorent.fn.hide_compare()

		compare_dialog: ->
			$(".compare_dialog_single").remove()
			unless sociorent.collections.compare_object.models.length == 0
				_.each sociorent.collections.compare_object.models, (model)->
					view = new sociorent.views.compare_dialog
						model: model
					$(view.render().el).insertBefore("#search_to_compare")
			$("#compare_dialog_box").dialog "open"

		scroll_app: ->
			if $("body").scrollTop() > 156
				$("#compare_box").css
					position: "fixed"
					top: "0px"
			else
				$("#compare_box").css
					position: "absolute"
					top: "156px"

		open_user_dialog: ->
			$("#user_dialog").dialog "open"

		select_reference: ->
			ambassador_id = parseInt $("#ambassador_select").val()
			if ambassador_id == 0
				alert "Please select your reference"
				false
			else
				$.ajax "/users/select_reference" ,
					type:"post"
					async:true
					data:
						ambassador_id: ambassador_id
					success: (msg)->
						$("#ambassador_select_box").html "Thank you."


	sociorent.views.app_object = new sociorent.views.app()