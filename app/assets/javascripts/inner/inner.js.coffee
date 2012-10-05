window.sociorent = window.sociorent || {fn: {}, models: {}, collections: {}, views: {}}

$(document).ready ->

	sociorent.fn.renderSearch = ()->
		$("#search_books").html ""
		if sociorent.collections.search_object.models.length > 0
			_.each sociorent.collections.search_object.models, (model)->
				view = new sociorent.views.search
					model: model
				$("#search_books").append view.render().el
		else 
			$("#search_books").append "<div class='no_search_result'>No books found.</div>"
	
	search = ()->
		$.ajax "/search" , 
			type:"post"
			async:true
			data:
				query: $("#search_books_input").val()
			success: (msg)->
				# reset the search collections
				console.log msg
				sociorent.collections.search_object.reset(msg)
				sociorent.fn.renderSearch()


	options =
	  callback: -> 
	  	search()
	  wait: 750
	  highlight: true
	  captureLength: 2

	$("#search_books_input").typeWatch options