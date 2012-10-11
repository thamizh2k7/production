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

		checkout: ->
			$("#cart_box").dialog("close")
			$("#checkout_box").dialog("open")

		create_order: ->
			$.ajax "/orders/create" ,
				type:"post"
				async:true
				success: (msg)->
					$("#checkout_box").dialog "close"
					$("#order_box").dialog "open"
					$("#order_id span").html msg.random
					sociorent.collections.cart_object.reset()
					sociorent.fn.renderSearch()
					sociorent.fn.renderCart()

		compare_close: ->
			sociorent.fn.hide_compare()

		compare_dialog: ->
			$("#compare_dialog").html ""
			unless sociorent.collections.compare_object.models.length == 0
				_.each sociorent.collections.compare_object.models, (model)->
					view = new sociorent.views.compare_dialog
						model: model
					$("#compare_dialog").append view.render().el
			else
				$("#compare_dialog").html "<div class='no_compare_book'>There are no books to compare.<br/>To add one click on compare in books tabs.</div>"
			$("#compare_dialog").dialog "open"

		scroll_app: ->
			if $("body").scrollTop() > 124
				$("#compare_box").css
					position: "fixed"
					top: "0px"
			else
				$("#compare_box").css
					position: "absolute"
					top: "124px"

	sociorent.views.app_object = new sociorent.views.app()