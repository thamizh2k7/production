window.sociorent = window.sociorent || {fn: {}, models: {}, collections: {}, views: {}}

$(document).ready ->
	
	# backbone model
	sociorent.models.search = Backbone.Model.extend()

	# backbone collection
	sociorent.collections.search = Backbone.Collection.extend
		model: sociorent.models.search

	# backbone view for  search
	sociorent.views.search = Backbone.View.extend
		tagName: "div"
		className: "search_books_single"

		template: _.template $("#search_template").html()

		initialize: ->
			_.bindAll this, 'render'
			that = this

		events:
			"click .add_to_cart" : "add_to_cart"
			"click .book_left" : "view_book_info"

		view_book_info: ->
			$("#book_details").html ""
			view = new sociorent.views.book_details
				model: @model
			$("#book_details").append view.render().el
			$("#book_details").dialog "open"


		add_to_cart: ->
			that = this
			$.ajax "/home/add_to_cart" ,
				type:"post"
				async:true
				data: 
					book: that.model.id 
				success: (msg)->
					window.location.href = "/users/sign_in"

		render: ->
			image = @model.get("book_image")
			original_image = @model.get("book_original")
			$(@el).html @template
				id: @model.id
				image: image
				original_image: original_image
				name: @model.get "name"
				author: @model.get "author"
				isbn: @model.get "isbn10"
				cart_message: "Add to Cart"
			this

	#backbone view for Book details
	sociorent.views.book_details = Backbone.View.extend
		tagName: "div"
		className: "book_details"
		template: _.template $("#book_details_template").html()
		initialize: ->
			_.bindAll this, 'render'

		render: ->
			$(@el).html @template(@model.toJSON())
			this



	# render all search result
	sociorent.fn.renderSearch = ()->
		$("#search_books").html ""
		if sociorent.collections.search_object.models.length > 0
			_.each sociorent.collections.search_object.models, (model)->
				view = new sociorent.views.search
					model: model
				$("#search_books").append view.render().el
			# highlight found value
			val = $("#search_books_input").val()
			unless $.trim(val) == ""
				$("#search_books .name, #search_books .isbn, #search_books .author").highlight(val)
			$("#no_search_result").hide()
		else 
			$("#search_books").append "<div id='no_search_result_caption'>No books found.</div>"
			$("#no_search_result").show()
		$("#search_books").stop().fadeIn(200)
		$("#searchClose").css
			visibility: "visible"

	# initialize collection
	sociorent.collections.search_object = new sociorent.collections.search()

	# search ajax request
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

	# type watch plugin for search box
	options =
	  callback: -> 
	  	search()
	  wait: 500
	  highlight: true
	  captureLength: 2

	$("#search_books_input").typeWatch options

	$("#search").submit ->
		search()
		false

	$("#searchClose").click ->
		$("#search_books").fadeOut 200
		$(this).css
			visibility: "hidden"