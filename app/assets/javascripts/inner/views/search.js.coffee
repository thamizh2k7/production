$(document).ready ->
	sociorent.views.search = Backbone.View.extend
		tagName: "div"
		className: "search_books_single"

		template: _.template $("#search_template").html()

		initialize: ->
			_.bindAll this, 'render'

		events:
			"click" : "details"

		details: ->
			$("#book_details").dialog("open")

		render: ->
			image = @model.get("book_image") || "/assets/book.jpeg"
			$(@el).html @template
				image: image
				name: @model.get "name"
				price: @model.get "price"
			this