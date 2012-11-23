$(document).ready ->
	sociorent.views.order = Backbone.View.extend
		tagName: "div"
		className: "order_single"

		template: _.template $("#order_template").html()

		initialize: ->
			_.bindAll this, 'render'
		
		render: ->
			created_at = @model.get("created_at").replace(/(T)|(Z)/gi, " ")
			that = this
			$(@el).html @template
				random: @model.get "random"
				created_at: created_at
				total: @model.get "total"
				rental_total: @model.get "rental_total"
				deposit_total: @model.get "deposit_total"
			# rendering books of this order
			_.each @model.get("books"), (obj)->
				model = new sociorent.models.order_book()
				model.set obj
				book_order = _.find that.model.get("book_orders"), (book_order)->
					book_order.book_id == model.id
				model.set book_order
				view = new sociorent.views.order_book
					model: model
				that.$(".order_books").append view.render().el
			this