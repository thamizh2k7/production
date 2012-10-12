$(document).ready ->
	sociorent.views.wishlist = Backbone.View.extend
		tagName:"div"
		className: "wishlist_single"

		template: _.template $("#wishlist_template").html()

		initialize: ->
			_.bindAll this, 'render'

		render: ->
			$(@el).html @template(@model.toJSON())
			this