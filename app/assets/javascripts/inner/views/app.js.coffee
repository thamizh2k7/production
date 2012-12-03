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
			$(window).scroll this.show_go_top

			# load more count
			sociorent.load_more = 0
		
		events:
			"submit #search_books_form"	: "cancel_submit"
			"submit #request_form" : "make_request"
			"click #cart_button" : "open_cart_dialog"
			"click #cart_options_right" : "checkout"
			"click .create_order" : "create_order"
			"click #compare_close" : "compare_close"
			"click #compare_dialog_button" : "compare_dialog"
			"click #compare_button" : "compare_dialog"
			"click #my_account_button" : "open_user_dialog"
			"submit #compare_search_form"	: "cancel_submit"
			"change #ambassador_select" : "select_reference"
			"click #update_shipping" : "update_shipping"
			"click #load_more" : "load_more"
			"click #go_top" : "go_top"

		cancel_submit: ->
			false

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

		update_shipping: ->
			if $("#shipping_form").valid()
				$.post "/update_shipping", $("#shipping_form").serialize(), (resp) ->
					if resp.text is "success"
						$("#shipping_details_box").dialog "close"
						$("#checkout_box").dialog "open"
						sociorent.models.user_object.set($.parseJSON(resp.user))
						view = new sociorent.views.user_dialog
							model: sociorent.models.user_object,
						$("#user_dialog").html(view.render().el)
						$("#profile_address_state").val(sociorent.models.user_object.get("address").address_state).chosen()
						if resp.gharpay == "true"
							$("#checkout_gharpay").show()
						else
							$("#checkout_gharpay").hide()


			false

		checkout: ->
			$("#cart_box").dialog("close")
			$("#shipping_details_box").dialog("open")
			console.log sociorent.models.user_object.get("address").address_state
			$("#address_state").val(sociorent.models.user_object.get("address").address_state).chosen()
			
		create_order: (event)->
			# get the order type
			order_type = $(event.target).attr "data-attr"
			accept_terms_of_use = $("#order_terms_and_conditions").attr("checked") ? true:false
			post_data = 
			if order_type == "bank"
				post_data["bank_id"] = $("#bank_name").val()
			$("#checkout_box_content").html "<div class='center'> Order processing...</div>"
			$.ajax "/orders/create" ,
				type:"post"
				async:true
				data:
					order_type :order_type
					accept_terms_of_use: accept_terms_of_use
				success: (msg)->
					$("#checkout_box").dialog "close"
					$("#order_box").dialog "open"
					$("#order_id span").html msg.random
					if order_type=="gharpay"
						$("#order_gharpay").show()
						$("#order_bank_cheque").hide()
					else
						$("#order_gharpay").hide()
						$("#order_bank_cheque").show()

					sociorent.collections.order_object.add(msg)
					sociorent.collections.cart_object.reset()
					sociorent.fn.renderSearch()
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

		show_go_top: ->
			if $(window).scrollTop() == 0
				$("#go_top").fadeOut 100
			else
				$("#go_top").fadeIn 100

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

		load_more: ->
			query = $.trim($("#search_books_input").val())
			$.ajax "/home/load_more" ,
				type:"post"
				async:true
				data:
					query: query
					load_more_count: ++sociorent.load_more
				success: (msg)->
					if msg.load_more
						$("#load_more").show()
					else
						$("#load_more").hide()
					_.each $.parseJSON(msg.books), (obj)->
						model = new sociorent.models.search(obj)
						view = new sociorent.views.search
							model: model
						$("#search_books").append view.render().el
						# highlight found value
					val = $("#search_books_input").val()
					unless $.trim(val) == ""
						$("#search_books .name, #search_books .isbn, #search_books .author").highlight(val)

		go_top: ->
			$("html, body").animate
				scrollTop: 0
			, 200

	sociorent.views.app_object = new sociorent.views.app()