window.sociorent = window.sociorent || {fn: {}, models: {}, collections: {}, views: {}}

$(document).ready ->

	sociorent.fn.renderSearch = ()->
		$("#search_books").hide().html ""
		if sociorent.collections.search_object.models.length > 0
			_.each sociorent.collections.search_object.models, (model)->
				view = new sociorent.views.search
					model: model
				$("#search_books").append view.render().el
			# highlight found value
			val = $("#search_books_input").val()
			unless $.trim(val) == ""
				$("#search_books div").highlight(val)
			$("#no_search_result").hide()
		else 
			$("#search_books").append "<div id='no_search_result_caption'>No books found.</div>"
			$("#no_search_result").show()
		$("#search_books").stop().fadeIn(300)

	sociorent.fn.renderCart = ()->
		$("#cart").html ""
		_.each sociorent.collections.cart_object.models, (model)->
			view = new sociorent.views.cart
				model: model
			$("#cart").append view.render().el

	
	search = ()->
		$.ajax "/search" , 
			type:"post"
			async:true
			data:
				query: $("#search_books_input").val()
			success: (msg)->
				# reset the search collections
				sociorent.collections.search_object.reset(msg)
				sociorent.fn.renderSearch()


	options =
	  callback: -> 
	  	search()
	  wait: 750
	  highlight: true
	  captureLength: 2

	$("#search_books_input").typeWatch options