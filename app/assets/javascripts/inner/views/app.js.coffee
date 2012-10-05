$(document).ready ->
	sociorent.views.app = Backbone.View.extend
		el: 'body'

		initialize: ->
			# search collection
			sociorent.collections.search_object = new sociorent.collections.search()
		
		events:
			"submit #search_books_form"	: "cancel_submit"

		cancel_submit: ->
			false

	sociorent.views.app_object = new sociorent.views.app()